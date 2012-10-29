From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: [PATCH v2 2/2] can: usb: esd_usb2: Add support for CAN-USB/Micro
Date: Mon, 29 Oct 2012 12:33:42 +0100
Message-ID: <508E6996.7070202@esd.eu>
References: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu> <1351504488-7060-3-git-send-email-matthias.fuchs@esd.eu> <508E59E1.4010901@pengutronix.de> <508E5A2B.1010405@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50500 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758747Ab2J2LeJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 07:34:09 -0400
In-Reply-To: <508E5A2B.1010405@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

your idea is a good catch. But let's keep my current patch.

Matthias

On 29.10.2012 11:27, Marc Kleine-Budde wrote:
> On 10/29/2012 11:26 AM, Marc Kleine-Budde wrote:
>> On 10/29/2012 10:54 AM, matthias.fuchs@esd.eu wrote:
>>> From: Matthias Fuchs <matthias.fuchs@esd.eu>
>>> 
>>> This patch extends the esd_usb2 driver to support the tiny
>>> CAN-USB/Micro CAN/USB interface.
> 
>> But I think your solution is easier. If you add more device a
>> conversion might become handy.
> 
> This means, I take your patch as is to can-next.
> 
> Marc
> 

