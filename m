From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH 0/2] can: usb: esd_usb2: Small fixes to esd_usb2 driver
Date: Wed, 18 Oct 2017 13:25:06 +0200
Message-ID: <68c42b9c-138d-e4fe-1b6a-5cf7e1ece88c@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp01.htp-tel.de ([212.59.41.8]:41529 "EHLO mxpout01.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753337AbdJRLZW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Oct 2017 07:25:22 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi,

here are provided a bug fix for receiving RTR frames and an editorial
change.

The patches apply cleanly to linux-can and linux-can-next.

REMARK: I tried to send these patches already on September, 04 but the
kernel mailing list server seemed to put them in /dev/null. I'll
try it again now.

REMARK2: My git send-email setup seems to be busted in some way and the
mailing list server throws the emails away again and again. Therefore I
now use Thunderbird and hope these mails go through.

It would be great if these small patches could reach the upcoming 4.14
kernel especially the fix for the can_dlc because that is the designated
kernel for the next Ubuntu LTS release.

Thanks in advance.

Stefan Mätje (2):
  can: usb: esd_usb2: Replaced stale MODULE_AUTHOR tag
  can: usb: esd_usb2: Fix can_dlc value for received RTR frames

 drivers/net/can/usb/esd_usb2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.11.0

