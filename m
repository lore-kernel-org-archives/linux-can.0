From: Andrew Beard <abeard@ovro.caltech.edu>
Subject: Re: Patch for libsocketcan
Date: Tue, 7 Aug 2012 08:09:41 -0700
Message-ID: <E4B66EB2-5183-4958-9B80-3E8F65900807@ovro.caltech.edu>
References: <6D9074C1-4B77-4D4B-BCF5-F13625B6DC05@ovro.caltech.edu> <5020C734.2090008@pengutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:59663 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab2HGPTU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Aug 2012 11:19:20 -0400
In-Reply-To: <5020C734.2090008@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ira Snyder <iws@ovro.caltech.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


On Aug 7, 2012, at 12:43 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Hello Andrew,
> 
> I've added linux-can on Cc.
> 
> On 08/03/2012 08:23 PM, Andrew Beard wrote:
>> Hi Marc,
>> Attached is a patch for what I believe is a bug in libsocketcan.
>> Please let me know if you have any questions.
> 
> Yes, it's a bug, Alexander Stein fixed it already, but I didn't apply
> his patch. Your patch, is the way better solution. You did not follow
> quite the kernel coding style, and put some variable definition into the
> loop. I fixed that an will commit it to the repo. Can I add your
> Signed-off-by[1] to the patch?

Hi Marc,
That would be fine.  
Thanks,
    ~Andy


> 
> Marc
> 
> [1]
> http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 

