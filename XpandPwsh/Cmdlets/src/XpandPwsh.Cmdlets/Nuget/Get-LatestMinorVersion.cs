using System;
using System.ComponentModel.DataAnnotations;
using System.Management.Automation;
using System.Reactive.Threading.Tasks;
using System.Threading.Tasks;
using JetBrains.Annotations;

namespace XpandPwsh.Cmdlets.Nuget{
    [Cmdlet(VerbsCommon.Get, "LatestMinorVersion")]
    [CmdletBinding]
    [CmdLetTag(CmdLetTag.Nuget,CmdLetTag.Reactive,CmdLetTag.RX)][PublicAPI]
    public class GetLatestMinorVersion : NugetCmdlet{
        [Parameter]
        public string Source{ get; set; } = Environment.GetEnvironmentVariable("DXFeed");
        [Parameter(Mandatory = true)]
        public string Id{ get; set; }
        [Parameter]
        public int? Top{ get; set; } = 3;
        [Parameter]
        public SwitchParameter IncludeDelisted{ get; set; } 
        [Parameter]
        public SwitchParameter IncludePrerelease{ get; set; }

        protected override Task BeginProcessingAsync(){
            
            if (Source == null){
                throw new ValidationException("Parameter Source cannot be empty");
            }
            return base.BeginProcessingAsync();
        }

        protected override Task ProcessRecordAsync(){
            return Providers.GetLatestMinors(Source, Id,Top,IncludePrerelease,IncludeDelisted).ToObservable().ToTask().WriteObject(this);
        }

    }
}

