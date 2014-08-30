-- [[ Nebula API ]] --
if not Nebula.NebulaAPI then
	Nebula.NebulaAPI.GitHub = {
		baseUrls = {
			html = 'https://github.com/';
			api = 'https://api.github.com/';
			raw = 'https://raw.githubusercontent.com/';
		};
		formatUrls = {
			html = {
				user = 'https://github.com/%s/';
				reposistory = 'https://github.com/%s/%s/';
				branch = 'https://github.com/%s/%s/%s/';
			};
			raw = {
				file = 'https://raw.githubusercontent.com/%s/%s/%s/%s/';
			};
			api = {
				user = 'https://api.github.com/users/%s/';
				reposistory = 'https://api.github.com/repos/%s/%s/';
			};
		};
		
		getRepositoryURL = function(self,creator,name,notRaw)
			if notRaw then
				return (self.formatUrls.html.repository):format(creator,name)
			else
				return (self.formatUrls.api.repository):format(creator,name)
			end
		end;
		
		getRepository = function(url)
			return (game:GetService("HttpService"):GetAsync(url,true))
		end;
		
		dumpRepository = function(repository)
			return (game:GetService("HttpService"):JSONDecode(repository))
		end;
		
		getRepositoryCreator = function(dumpedRepository)
			return dumpedRepository.owner.login;
		end;
		
		getCollaborators = function(dumpedRepository)
			return (game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync((dumpedRepository.url .. '/collaborators/'),true)))
		end;
		
		getBranches = function(dumpedRepository)
			return (game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync((dumpedRepository.url .. '/branches/'),true)))
		end;
		
		getBranch = function(branch)
			return game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync((dumpedRepository.url .. '/branches/' .. branch .. '/'),true))
		end;
		
		getBranchContents = function(dumpedBranch)
			return dumpedBranch.files;
		end;
		
		getBranchFilesContent = function(branchContents, fileName)
			for i,v in pairs(branchContents) do
				if v.filename==fileName then
					return {contents=v, getRaw = function(self)
						return (game:GetService("HttpService"):GetAsync(self.raw_url,true))
					end}
				end
			end
		end;
	}
else
	print('Nebula API already loaded.')
end