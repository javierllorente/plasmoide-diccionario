#
# spec file for package plasmoide-diccionario
#
# Copyright (c) 2016 SUSE LINUX Products GmbH, Nuernberg, Germany.
# Copyright (c) 2016 Javier Llorente
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           plasmoide-diccionario
Version:        0.1
Release:        1
Summary:        A Castilian RAE dictionary client
License:        GPL-2.0 or GPL-3.0
Group:          Productivity/Office/Dictionary
Url:            https://github.com/javierllorente/plasmoide-diccionario
Source:         plasmoide-diccionario-%{version}.tar.bz2
BuildRequires:  cmake(KF5Plasma)
BuildRequires:  fdupes
BuildArch:      noarch
Requires:       plasma5-desktop
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Plasmoid for looking up words in the Castilian RAE Dictionary

%prep
%setup -q -n %{name}

%build
%cmake_kf5 -d build

%install
%kf5_makeinstall -C build
%fdupes -s %{buildroot}

%files
%defattr(-,root,root)
%dir %{_kf5_plasmadir}/plasmoids
%{_kf5_plasmadir}/plasmoids/org.kde.plasma.diccionario
%{_kf5_servicesdir}/plasma-applet-org.kde.plasma.diccionario.desktop

%changelog
