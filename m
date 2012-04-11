From: Markus Becker <mab@comnets.uni-bremen.de>
Subject: ITP: can-utils Debian package
Date: Wed, 11 Apr 2012 15:09:12 +0200
Message-ID: <201204111509.12688.mab@comnets.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bugs.comnets.uni-bremen.de ([134.102.186.10]:50622 "EHLO
	bugs.comnets.uni-bremen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760221Ab2DKNQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 09:16:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 568303@bugs.debian.org
Cc: linux-can@vger.kernel.org

Hi,

after a long absence, I have updated the Debian packages of socketCAN.

Now there are two packages (for the moment) can-utils and can-modules, which 
are based on the gitorious repositories of the same name. The package name has 
changed from socketcan-utils to can-utils to reflect the current layout on 
gitorious.


* can-utils is the main package with the executables.
The gitweb of Debian for can-utils is now at:
http://anonscm.debian.org/gitweb/?p=collab-maint/can-utils.git;a=summary

The following should create and install a Debian package of can-utils for you:
<shell>
git clone git://anonscm.debian.org/collab-maint/can-utils.git
cd can-utils
git-buildpackage
sudo dpkg -i ../can-utils_0.0.2+gitba9b189-1_i386.deb
</shell>

Have the man pages been removed intentionally from can-utils in the transition 
from Berlios to gitorious? For the moment the packages don't include the 
manpages therefore.


* As we are needing Debian packages for ISO-TP and it is not yet in the 
mainline kernel AFAIK, I have also created a package with can-bcm.ko, can-
isotp.ko, can.ko and can-raw.ko. Please correct me, if this is already on the 
way into the mainline kernel. (gitorious gives me lots of 500's for commit 
overview, etc.) Once it has landed there, this package is not needed anymore.

gitweb of can-modules:
http://anonscm.debian.org/gitweb/?p=collab-maint/can-modules.git;a=summary

Procedure:
<shell>
git clone git://anonscm.debian.org/collab-maint/can-modules.git
cd can-modules
git-buildpackage
sudo dpkg -i ../can-modules_0.0.2+git6b92067-1_all.deb
sudo m-a a-i -t can-modules
</shell>

Feedback on the packages is appreciated.

BR,
Markus

------------------------------------------------
| Dipl.-Ing. Markus Becker
| Communication Networks
| TZI - Center for Computing Technologies
| University Bremen
| Germany
------------------------------------------------
| web: http://www.comnets.uni-bremen.de/~mab/
| mailto: mab@comnets.uni-bremen.de
| telephone: +49 421 218 62379
| building: NW1 room: N2260
------------------------------------------------
