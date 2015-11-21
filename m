From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can support at Linux LXC?
Date: Sat, 21 Nov 2015 13:33:53 +0100
Message-ID: <565064B1.7040502@hartkopp.net>
References: <564F94B7.2080603@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:57286 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbKUMd7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2015 07:33:59 -0500
In-Reply-To: <564F94B7.2080603@debian.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dererk <dererk@debian.org>, linux-can@vger.kernel.org

Hi Dererk,

On 11/20/2015 10:46 PM, Dererk wrote:

> I'm playing with some bus CANs and linux LXC. But it seems that there
> must be some kind of support missing on the LXC side.
> Even vcan seems to have the very same results on it when trying to open
> the socket:
> 
> socket(PF_CAN, SOCK_RAW, 1)             = -1 EAFNOSUPPORT (Address
> family not supported by protocol)
> 
> Have you have any experience with this?

Looks like CONFIG_CAN and other CAN specific components are not enabled in
your kernel.

Debian kernels usually have this enabled:

$ grep CONFIG_CAN /boot/config-3.16.0-4-amd64
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_EMS_PCMCIA=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_MCP251X is not set
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_PEAK_USB=m
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m
# CONFIG_CAN_DEBUG_DEVICES is not set


> Is there a proper place where I could route this doubts at an
> specialized mailing list on the linux kernel that you know might be more
> appropiate?

You are definitely at the right place for CAN related questions here :-)

Best regards,
Oliver

