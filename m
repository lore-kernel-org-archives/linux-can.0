From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 08:18:02 +0100
Message-ID: <50A4972A.9070707@hartkopp.net>
References: <loom.20121114T160521-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:50296 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204Ab2KOHSG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 02:18:06 -0500
In-Reply-To: <loom.20121114T160521-534@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, Alexander Stein <alexander.stein@systec-electronic.com>, federico.vaga@gmail.com, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

On 14.11.2012 16:39, Michael Pellegrini wrote:


> I am trying to use the pch_can driver to interface with a CANopen system.
> I am encountering a serious issue where, at random intervals, the CAN interface
> will lock up and stop transmitting data.  Data reception continues normally.
> The only way I've found to resolve the issue so far is to issue an
> "ifconfig canx down" command followed by an "ifconfig canx up" command.
> After the interface is reset through these commands, the TX packet dropped count
> and the TX packet carrier count increment by 1.
> 
> I am running Ubuntu 12.04 with kernel version 3.2.0-23.
> 
> Has anyone else seen this problem or have a fix for it?


Hello Mike,

i put the relevant people into CC that probably know better than me.

Btw. using the pch_can driver:

1. Can you please provide the output of 

	ip -details link show can0

(if can0 is your device with the problem)
at start time and when the problem happened?

2. Can you send the output of

	candump can0,0~0,#FFFFFFFF -e

from start time until the problem happens?

3. It turned out that the pch_can controller is created upon the C_CAN
CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
pch_can driver with a PCI-attached C_CAN driver:

http://thread.gmane.org/gmane.linux.can/815

I don't know the current state of the tests/replacement.

But a general C_CAN PCI driver has been contributed by Frederico Vaga which
became a mainline driver in June

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5b92da0443c2585e31b64e86c2e1b8e22845d4bb

Don't know if this driver can be used out of the box, when the PCI IDs of the
PCH_CAN board are added ...

But maybe the guys in CC know ;-)

Regards,
Oliver



