From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Softing Firmware on gitorious
Date: Wed, 11 Jan 2012 17:57:22 +0100
Message-ID: <3458527.PgLK1e9PLF@ws-stein>
References: <4F0DB66F.50509@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:47089 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab2AKQ5b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 11:57:31 -0500
In-Reply-To: <4F0DB66F.50509@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

On Wednesday 11 January 2012 17:18:55 Oliver Hartkopp wrote:
> The question is now:
> 
> 1. change the link in the Kconfig
> 2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
> 3. 1 & 2

According to firmware/README.AddingFirmware new firmware files should go to 
git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
For more details see the mentioned readme file.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
