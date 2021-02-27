# maxiconda

Cross platform conda installer purely based on [conda-forge](https://conda-forge.org/) with [Python](https://www.python.org/) ([CPython](https://en.wikipedia.org/wiki/CPython), [Jupyter](https://jupyter.org/) and [R](https://www.r-project.org/) for users. 

[![GitHub](https://img.shields.io/github/license/Semi-ATE/maxiconda?color=black)](https://github.com/Semi-ATE/maxiconda/blob/main/LICENSE)

[![CI](https://github.com/Semi-ATE/DT/workflows/CI/badge.svg?branch=main)](https://github.com/Semi-ATE/maxiconda/actions?query=workflow%3ACI)
[![CD](https://github.com/Semi-ATE/maxiconda/workflows/CD/badge.svg)](https://github.com/Semi-ATE/maxiconda/actions?query=workflow%3ACD)

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Semi-ATE/maxiconda?color=blue&label=GitHub&sort=semver)](https://github.com/Semi-ATE/maxiconda/releases/latest)
[![PyPI](https://img.shields.io/pypi/v/maxiconda?color=blue&label=PyPI)](https://pypi.org/project/maxiconda/)
![Conda (channel only)](https://img.shields.io/conda/vn/conda-forge/maxiconda?color=blue&label=conda-forge)
[![GitHub commits since latest release (by date)](https://img.shields.io/github/commits-since/Semi-ATE/maxiconda/latest)](https://github.com/Semi-ATE/maxiconda)

[![GitHub issues](https://img.shields.io/github/issues/Semi-ATE/DT)](https://github.com/Semi-ATE/maxiconda/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/Semi-ATE/maxiconda)](https://github.com/Semi-ATE/maxiconda/pulls)

# raison d'être

The 'raison d'être' of this installer is that the [Anaconda](https://docs.anaconda.com/anaconda/install/) installer **does not support** [aarch64](https://en.wikipedia.org/wiki/AArch64) processors, neighter does the [miniconda]() installer out of the box as both are based on the [anaconda channel](). There is the [miniforge](https://github.com/conda-forge/miniforge) installer though, however this one (as miniconda) installs a (very) basic `base` environment, and leaves it up to the user to do some more command line magic to get things going.

`miniconda` and `miniforge` where designed with CI in mind, `Anaconda` was designed with the **user** in mind, if we put this in a table, it becomes clear where `maxiconda` fits in :

 ![conda table](https://github.com/Semi-ATE/maxiconda/blob/main/conda_table.png)

maxiconda is thus the equivalent of `anaconda` when we want to use `conda-forge` as a base channel.

maxiconda is also installing things a bit different then anaconda in that it :

  1. Installs a small `base` environment (as miniconda and miniforge do), but as conda-forge is so big also [mamba](https://github.com/mamba-org/mamba) is already added to the `base` environment, [git](https://anaconda.org/conda-forge/git) is also always needed and ...  [ofcourse](https://www.youtube.com/watch?v=Ul79ihg41Rs) [pip](https://anaconda.org/conda-forge/pip) is removed! Note that all sub-sequent conda environments enherit form `base`, so this is to be a  lean-mean-fighting-machine environment!
  2. Installs a `_spyder_` (application) environment where [spyder](https://www.spyder-ide.org/) and **all** it's dependencies (required, optional and extra) live.
  3. Installs a `maxiconda` (development) environment much like the one anaconda inc. installs in the `base` environment 😒 when using their installer(s), modified a bit, as it no longer holds spyder and it's dependencies, but **ONLY** the [spyder-kernels](https://github.com/spyder-ide/spyder-kernels) and [spyder-remote-server](https://github.com/Semi-ATE/spyder-remote) packages.

It is also organized such that, when starting a terminal, the `maxiconda` environment is activated (to prevent accidental screwing up the `base` environment 😏)

# Support & Installation

Based on your OS, download the installer from the table below :

| OS      |Architecture                | Python | Download                                                                             |
|:--------|:---------------------------|:--------------:|:-------------------------------------------------------------------------------------|
| Windows | x86_64                     |CPython         | [![maxiconda-windows](https://img.shields.io/badge/maxiconda%20installer-Windows-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.msi)        |
| Linux   | x86_64 / aarch64 / ppc64le | CPython / PyPy | [![maxiconda-linuxmac](https://img.shields.io/badge/maxiconda%20installer-Linux&amp;MacOS-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.sh) |
| MacOS   | x86_64 / M1⁽¹⁾             | CPython / PyPy | [![maxiconda-linuxmac](https://img.shields.io/badge/maxiconda%20installer-Linux&amp;MacOS-blue)](https://github.com/Semi-ATE/maxiconda/releases/latest/download/maxiconda.dmg) |

⁽¹⁾ Experimental

For (re)installation, run the installer on your local machine :

- Windows : double click the downloaded `maxiconda.exe` file and follow the instructions.
- Linux & MacOS : run the downloaded `maxiconda.sh` script in a terminal and follow the instructions.

Note that PyPy is only supported under Linux an MacOS, and to use it run the installation script as follows : `./maxiconda.sh --pypy`

# Environments and their packages

 ![base](https://img.shields.io/badge/packages-base-red)

 ![_spyder_](https://img.shields.io/badge/packages-__spyder__-orange)

 ![maxiconda](https://img.shields.io/badge/packages-maxiconda-green)
