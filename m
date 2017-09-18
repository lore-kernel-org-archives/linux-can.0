From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH 0/2] can: usb: esd_usb2: Small fixes to esd_usb2 driver
 (request for review)
Date: Mon, 18 Sep 2017 19:59:48 +0200
Message-ID: <c0f6eb16-92ac-3997-63ea-846810de9e56@esd.eu>
References: <20170904122641.18592-1-stefan.maetje@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp02.htp-tel.de ([212.59.41.9]:50364 "EHLO mxpout02.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbdIRSAG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 18 Sep 2017 14:00:06 -0400
In-Reply-To: <20170904122641.18592-1-stefan.maetje@esd.eu>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi,

I would like to ask if some of you could be so kind to review the driver
patches referenced in this thread.

The patches have been tested with an esd CAN-USB/2 USB-to-CAN interface.

The patch #2 fixes the reception of RTR frames and has only two changed
lines. The effort to review it should be very small.

Best regards,
    Stefan Mätje

Am 04.09.2017 um 14:26 schrieb Stefan Mätje:
> Hi,
> 
> here are provided a bug fix for receiving RTR frames and an editorial
> change.
> 
> The patches apply cleanly to linux-can and linux-can-next.
> 
> 
> Stefan Mätje (2):
>   can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
>   can: usb: esd_usb2: Fix can_dlc value for received RTR frames
> 
>  drivers/net/can/usb/esd_usb2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
