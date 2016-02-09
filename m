From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can utils for CANFD
Date: Tue, 9 Feb 2016 20:59:02 +0100
Message-ID: <56BA4506.30204@hartkopp.net>
References: <DA6901612C71B84D91459DE817C418AE26D8B38E@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:60476 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbcBIT7G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Feb 2016 14:59:06 -0500
In-Reply-To: <DA6901612C71B84D91459DE817C418AE26D8B38E@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>

Hi,

the can-utils you downloaded from https://github.com/linux-can/can-utils
support CAN-FD since 2012 (and Linux 3.6):

http://can-newsletter.org/engineering/standardization/nr_stand_can-fd_linux3.6_120703

And since Linux 3.15 the CAN driver infrastructure is part of Linux mainline
kernel:

http://can-newsletter.org/engineering/standardization/140513_can-fd-linux-tools-and-driver-infrastructure_peak_vw

The ip tool from the iproute2 package provides the configuration of CAN FD
hardware too. See documentation at:

https://www.kernel.org/doc/Documentation/networking/can.txt

See chapters 6.5 & 6.6 there.

An example how a real world CAN FD interface is configured:
http://www.peak-system.com/forum/viewtopic.php?f=177&t=1296

Just if you refer to the CAN tools hosted by Pengutronix ...

	http://git.pengutronix.de/?p=tools/canutils.git

... the canconfig tool provided there does NOT support CAN FD for now.

Same applies to

	http://git.pengutronix.de/?p=tools/libsocketcan.git

Regards,
Oliver


On 02/09/2016 11:18 AM, Naga Sureshkumar Relli wrote:
> Hi Marc,
> 
> I am adding Xilinx_canfd driver for Xilinx CANFD IP.
> So to test that, I have downloaded https://github.com/linux-can/can-utils.
> 
> But it doesn't have canconfig option, to configure CANFD Controller. Like bitrate, mode etc...
> 
> It has only ip command support, but this ip utility doesn't have support to change can mode (Normal operation Mode).
> It has only loopback mode support.
> 
> So, the can-utils, which I am using are the correct utils or not?
> 
> Suggest me, which one to use, to test CANFD.
> 
> Thanks,
> Naga Sureshkumar Relli.
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
