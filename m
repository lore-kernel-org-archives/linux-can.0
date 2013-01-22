From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: candump -x: brs esi is set on non-canfd interfaces
Date: Tue, 22 Jan 2013 09:44:09 +0100
Message-ID: <50FE5159.9090105@volkswagen.de>
References: <2839107.LG5rdvYUWD@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:34008 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3AVIoQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 03:44:16 -0500
In-Reply-To: <2839107.LG5rdvYUWD@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Am 22.01.2013 08:55, schrieb Alexander Stein:

> a student noticed that during his CANopen SDO transfer traffic candump sometimes shows e.g.
>> (000.000124)  can0  TX B E  641   [8]  00 32 33 34 35 36 37 38
> while on a non-canfd interfaces. It seem to occur at some time and disappears again for one SDO transfer and it occurs for another transfer and stays forever. I see that candump always uses struct canfd_frame, but AFAICS the flags member should not be set at all, as alloc_can_skb does a memset on struct can_frame. So the padding bytes in can_frame are zero which are used for flags in canfd_frame.
> When printing flags directly it is set to 0x7F. Has anybody an idea what could cause this? I could find any position which would manipulate the flags byte.
>

Is it possible that you generate that CAN frame on the local host?
If you do not zero the struct CAN frame before sending it e.g. via CAN_RAW 
socket this could be an idea where it comes from.

Because as you already pointed out alloc_can_skb() initializes the struct 
properly. But this only is relevant from CAN frames from 'the outside'.

Best regards,
Oliver

