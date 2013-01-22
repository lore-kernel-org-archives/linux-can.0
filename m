From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: candump -x: brs esi is set on non-canfd interfaces
Date: Tue, 22 Jan 2013 09:58:54 +0100
Message-ID: <2827513.Ik1JmLTmS7@ws-stein>
References: <2839107.LG5rdvYUWD@ws-stein> <50FE5159.9090105@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58540 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221Ab3AVI66 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 03:58:58 -0500
In-Reply-To: <50FE5159.9090105@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can@vger.kernel.org

Hello Oliver,

On Tuesday 22 January 2013 09:44:09, Oliver Hartkopp wrote:
> Am 22.01.2013 08:55, schrieb Alexander Stein:
> 
> > a student noticed that during his CANopen SDO transfer traffic candump sometimes shows e.g.
> >> (000.000124)  can0  TX B E  641   [8]  00 32 33 34 35 36 37 38
> > while on a non-canfd interfaces. It seem to occur at some time and disappears again for one SDO transfer and it occurs for another transfer and stays forever. I see that candump always uses struct canfd_frame, but AFAICS the flags member should not be set at all, as alloc_can_skb does a memset on struct can_frame. So the padding bytes in can_frame are zero which are used for flags in canfd_frame.
> > When printing flags directly it is set to 0x7F. Has anybody an idea what could cause this? I could find any position which would manipulate the flags byte.
> >
> 
> Is it possible that you generate that CAN frame on the local host?
> If you do not zero the struct CAN frame before sending it e.g. via CAN_RAW 
> socket this could be an idea where it comes from.
> 
> Because as you already pointed out alloc_can_skb() initializes the struct 
> properly. But this only is relevant from CAN frames from 'the outside'.

I don't know about the details that much, but you actually might be right. I will forward your suggestion and reply with the response.

Thanks so far.
Alexander

