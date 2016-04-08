From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Fri, 8 Apr 2016 11:04:44 +0200
Message-ID: <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
References: <loom.20160405T174008-515@post.gmane.org>
 <20160406074653.GA28692@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87093BDE@POCITMSEXMB05.LntUniverse.com>
 <20160406194026.GD5242@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095498@POCITMSEXMB05.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:45770 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcDHJHX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2016 05:07:23 -0400
Content-Disposition: inline
In-Reply-To: <03B271BE48E2554EB34508DAB79DBABA87095498@POCITMSEXMB05.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

> Kurt,
> I am facing deb-pkg error while building the kernel. Need your guidance on that.
> 
> Steps below.
> 1. I cloned the kernel from "http://kernel.ubuntu.com/git/kernel-ppa/mirror/ubuntu-vivid.git/commit/?id=32ac5b4aae56cf9446c30463663c8ae2226069da" with tag name "Ubuntu-3.19.0-56.62"
> 2. Then I added "git remote add j1939 git://github.com/kurt-vd/linux"
> 3. git remote update j1939
> 4. git merge j1939/j1939d-v3.15
> 5. Merge was successful without any issues.
> 6. cp /boot/config-3.19.0.56-generic .config
> 7. yes ' ' | make oldconfig
> 8. make menuconfig -> added SAE J1939 support and debugging support for J1939 and CAN messages
> 9. make -j 3 deb-pkg LOCALVERSION=-custome

I think you did everything well up to step 9.
My knowledge on building kernels specific for debian/Ubuntu  is limited.
Yet, the command you issue seems strange.
Shouldn't you just do:

	$ make -j 3 LOCALVERSION=-custome

and then

	$ sudo make install

Kind regards,
Kurt
