function test_pull1331

% MEM 1gb
% WALLTIME 00:10:00
% DEPENDENCY ft_prepare_layout ft_preprocessing ft_channelrepair
% DATA public

load(fullfile(fileparts(which('ft_defaults')),'template/neighbours/ctf151_neighb.mat'));
lay = ft_prepare_layout(struct('layout',fullfile(fileparts(which('ft_defaults')),'template/layout/CTF151.lay')));


cfg = [];
cfg.dataset = dccnpath('/project/3031000.02/external/download/test/ctf/Subject01.ds');
cfg.trl     = [1 1200 0;1201 2400 0];
cfg.continuous = 'yes';
data = ft_preprocessing(cfg);


cfg = [];
cfg.badchannel =     {'MLC11','MLC12','MLC13' };

cfg.neighbours = neighbours;
cfg.layout = lay;
data_clean = ft_channelrepair(cfg,data);

