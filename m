From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Sat, 9 Apr 2016 13:40:19 +0200
Message-ID: <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
References: <loom.20160405T174008-515@post.gmane.org>
 <20160406074653.GA28692@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87093BDE@POCITMSEXMB05.LntUniverse.com>
 <20160406194026.GD5242@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095498@POCITMSEXMB05.LntUniverse.com>
 <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
 <570793F6.7080808@eurek.it>
 <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:49241 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbcDILnA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 9 Apr 2016 07:43:00 -0400
Content-Disposition: inline
In-Reply-To: <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
Cc: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--- Original message ---
> Date: Fri, 8 Apr 2016 14:29:02 +0000
> From: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, gianluca
>  <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org"
>  <linux-can@vger.kernel.org>
> Subject: RE: J1939 Linux
> 
> Kurt and Eurek,
> I did follow the same steps except that I did not enable J1939 option in menuconfig.
> The build was successful and I am able to install the new custom kernel and reboot without any issues.
> Looks like I am facing the problem only when I enable J1939 option under menuconfig.
> 
> Hope this helps you to narrow down the problem.

On my Slackware, I get as far as:

	INSTALL debian/headertmp/usr/include/linux/wimax/ (1 file)
	INSTALL debian/headertmp/usr/include/linux/ (420 files)
	INSTALL debian/headertmp/usr/include/asm/ (65 files)
	Using default distribution of 'unstable' in the changelog
	Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
	./scripts/package/builddeb: line 31: dpkg-gencontrol: command not found
	make[1]: *** [deb-pkg] Error 127
	make: *** [deb-pkg] Error 2

This is anyhow beyond my expertise. 
Since it clearly seems to be caused by my can-j1939, I will help to find
it. Can you show a bit more output where the build fails?
Possibly with V=2 commandline parameter?

Kurt
