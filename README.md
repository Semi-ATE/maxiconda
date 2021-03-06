# maxiconda

[Cross platform](https://en.wikipedia.org/wiki/Cross-platform_software) [conda](https://en.wikipedia.org/wiki/Conda_(package_manager)) [installer](https://en.wikipedia.org/wiki/Installation_(computer_programs)#Installer) purely based on [conda-forge](https://conda-forge.org/) with [Python](https://www.python.org/) ([CPython](https://en.wikipedia.org/wiki/CPython) or [PyPy](https://en.wikipedia.org/wiki/PyPy)) and [R](https://www.r-project.org/) for users. 

[![GitHub](https://img.shields.io/github/license/Semi-ATE/maxiconda?color=black)](https://github.com/Semi-ATE/maxiconda/blob/main/LICENSE)

[![CI](https://github.com/Semi-ATE/maxiconda/workflows/CI/badge.svg?branch=main)](https://github.com/Semi-ATE/maxiconda/actions?query=workflow%3ACI)
[![CD](https://github.com/Semi-ATE/maxiconda/workflows/CD/badge.svg)](https://github.com/Semi-ATE/maxiconda/actions?query=workflow%3ACD)

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Semi-ATE/maxiconda?color=blue&label=GitHub&sort=semver)](https://github.com/Semi-ATE/maxiconda/releases/latest)
[![GitHub commits since latest release (by date)](https://img.shields.io/github/commits-since/Semi-ATE/maxiconda/latest)](https://github.com/Semi-ATE/maxiconda)

[![GitHub issues](https://img.shields.io/github/issues/Semi-ATE/maxiconda)](https://github.com/Semi-ATE/maxiconda/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/Semi-ATE/maxiconda)](https://github.com/Semi-ATE/maxiconda/pulls)

## raison d'être

The 'raison d'être' of this installer is that the [anaconda](https://docs.anaconda.com/anaconda/install/) installer **does not support** [arm](https://en.wikipedia.org/wiki/ARM_architecture) processors, neighter does the [miniconda]() installer out of the box as both are based on the [anaconda channel](). There is the [miniforge](https://github.com/conda-forge/miniforge) installer though, however this one (as miniconda) installs a (very) basic `base` environment, and leaves it up to the user to do some more command line magic to get things going.

`miniconda` and `miniforge` where designed with [CI](https://en.wikipedia.org/wiki/Continuous_integration) in mind, `anaconda` was designed with the **user** in mind, if we put this in a table, it becomes clear where `maxiconda` fits in :

 ![installer table](https://github.com/Semi-ATE/maxiconda/blob/main/doc/installer_table.png)

`maxiconda` is thus the equivalent of `anaconda` when we want to use `conda-forge` as a base channel.

`maxiconda` is also installing things a bit different then `anaconda` in that it :

  1. Installs a small `base` environment (as miniconda and miniforge do), but as the  `conda-forge` channel is [much bigger](https://anaconda.org/conda-forge/) than the `anaconda` channel, also [mamba](https://github.com/mamba-org/mamba) is already added to the `base` environment, [git](https://anaconda.org/conda-forge/git) is always needed and ...  [ofcourse](https://www.youtube.com/watch?v=Ul79ihg41Rs) [pip](https://anaconda.org/conda-forge/pip) is removed!
  2. Installs a `_spyder_` (application) environment where [spyder](https://www.spyder-ide.org/) and **all** it's dependencies (required, optional and extra) live.
  3. Installs a `maxiconda` (development) environment much like the one that `anaconda` installs in the `base` environment 😒 modified a bit, as it no longer holds spyder and it's dependencies, but **ONLY** the [spyder-kernels](https://github.com/spyder-ide/spyder-kernels) and [spyder-remote-server](https://github.com/Semi-ATE/spyder-remote) packages. Furthermore a series of extra packages are added, [see here](https://github.com/Semi-ATE/maxiconda-meta/blob/main/metapackages.xlsx) for the full- and current package list. 

It is also organized such that, when starting a terminal, the `maxiconda` environment is activated (to prevent accidental screwing up the `base` environment 😏)

## Support & Installation

| OS       |Architecture                | Python | Download                                                                             | Install |
|:---------|:---------------------------|:--------------:|:-------------------------------------------------------------------------------------|:----:|
| Windows  | x86_64                     |CPython         | [![maxiconda-windows](https://img.shields.io/badge/maxiconda%20installer-Windows-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.exe)        | [![Install video](https://github.com/Semi-ATE/maxiconda/blob/main/doc/PlayVideo.png)]() |
| Linux    | x86_64 / aarch64 / ppc64le | CPython / PyPy | [![maxiconda-linuxmac](https://img.shields.io/badge/maxiconda%20installer-Linux&amp;MacOS-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.sh) | [![Install video](https://github.com/Semi-ATE/maxiconda/blob/main/doc/PlayVideo.png)]() |
| MacOS    | x86_64 / M1⁽¹⁾             | CPython / PyPy | [![maxiconda-linuxmac](https://img.shields.io/badge/maxiconda%20installer-Linux&amp;MacOS-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.sh) | [![Install video](https://github.com/Semi-ATE/maxiconda/blob/main/doc/PlayVideo.png)]() |

⁽¹⁾ experimental

## Environments and their packages

 ![base](https://img.shields.io/badge/packages-base-red)

 ![_spyder_](https://img.shields.io/badge/packages-__spyder__-orange)

 ![maxiconda](https://img.shields.io/conda/pn/Semi-ATE/maxiconda) 
 
