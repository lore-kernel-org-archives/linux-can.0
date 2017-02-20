From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: iproute2 not function on CAN FD
Date: Mon, 20 Feb 2017 08:56:43 +0100
Message-ID: <f4c78670-8c25-8ee3-5167-126d49ad5b00@hartkopp.net>
References: <F9F4555C4E01D7469D37975B62D0EFBB4D7587@CHN-SV-EXMX07.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:25201 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdBTH6A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 02:58:00 -0500
In-Reply-To: <F9F4555C4E01D7469D37975B62D0EFBB4D7587@CHN-SV-EXMX07.mchp-main.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wenyou.Yang@microchip.com, mkl@pengutronix.de, wg@grandegger.com
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/20/2017 02:12 AM, Wenyou.Yang@microchip.com wrote:

> I am testing the CAN FD of M_CAN on the SAMA5D2 Xplained board,
> when using the ip tool from iprounte2 suite to set the CAN interface,
> it doesn't work with the message "RTNETLINK answers: Operation not supported".
> --->8----
> # ip link set can0 type can bitrate 125000 dbitrate 8000000 fd on
> RTNETLINK answers: Operation not supported

Please try:

# ip link set can0 type can bitrate 125000 dbitrate 8000000 fd on 
fd-non-iso on

The driver for the M_CAN IP core 3.0.x in the mainline kernel supports a 
NON_ISO IP core.

This non-iso setting is fixed with this v3.0.x M_CAN and we decided to 
make this configuration explicit - as all other options run into a mess.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=bb208f144cf3f59d8f89a09a80efd04389718907

Did that help?

Regards,
Oliver

