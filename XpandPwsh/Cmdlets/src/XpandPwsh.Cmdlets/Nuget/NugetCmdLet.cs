﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using NuGet.Protocol.Core.Types;
using XpandPwsh.CmdLets;

namespace XpandPwsh.Cmdlets.Nuget{
    public abstract class NugetCmdlet : XpandCmdlet{
        static NugetCmdlet(){
            AppDomain.CurrentDomain.AssemblyResolve+=CurrentDomainOnAssemblyResolve;
            Providers = new List<Lazy<INuGetResourceProvider>>();
            Providers.AddRange(Repository.Provider.GetCoreV3());
        }

        public static List<Lazy<INuGetResourceProvider>> Providers{ get; }

        private static Assembly CurrentDomainOnAssemblyResolve(object sender, ResolveEventArgs args){
            if (args.Name.Contains("Newton")){
                return Assembly.LoadFile(
                    $@"{Path.GetDirectoryName(typeof(GetNugetPackageSearchMetadata).Assembly.Location)}\Newtonsoft.Json.dll");
            }
            return null;
        }
    }
}