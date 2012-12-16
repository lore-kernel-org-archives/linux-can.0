From: Markus Becker <mab@comnets.uni-bremen.de>
Subject: Re: Debian packages for can-utils
Date: Sun, 16 Dec 2012 11:37:46 +0100
Message-ID: <201212161137.47176.mab@comnets.uni-bremen.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bugs.comnets.uni-bremen.de ([134.102.186.10]:58118 "EHLO
	bugs.comnets.uni-bremen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112Ab2LPKpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 16 Dec 2012 05:45:41 -0500
Received: from shelbyville.comnets.uni-bremen.de (unknown [10.8.0.62])
	by bugs.comnets.uni-bremen.de (Postfix) with ESMTPS id 7126ED409A5
	for <linux-can@vger.kernel.org>; Sun, 16 Dec 2012 11:37:48 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I did package can-utils 0.0.2 in April.

The packaging is available in:
http://anonscm.debian.org/gitweb/?p=collab-maint/can-utils.git;a=summary

From that, one can create deb's using dpkg-buildpackage.

Some time ago I submitted the built packages to mentors.debian.net, but they 
were not sponsored by a maintainer.

If you want, you could help on adapt the packaging for the upcoming release.

Markus


> Hey guys,
> 
> Is anyone working on Debian packages for can-utils?
> 
> mfg, Stefan.
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
