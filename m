From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 04 Nov 2014 14:24:02 +0100
Message-ID: <5458D372.3020604@hartkopp.net>
References: <1415080039-38327-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:41877 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaKDNYM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Nov 2014 08:24:12 -0500
In-Reply-To: <1415080039-38327-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VGhvbWFzIEvDtnJwZXI=?= <thomas.koerper@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Thomas,

looks far better to me now. Thanks.

@Marc: The only two questions I would have is this pretty short commit =
message=20
and the module parameter.
What do you think about it (and the rest)?

Regards,
Oliver

On 04.11.2014 06:47, Thomas K=C3=B6rper wrote:
> See http://esd.eu/en/products/can-pcie402 for hardware details.
>
> Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>


> +
> +static int dump_infos;
> +module_param(dump_infos, int, S_IRUGO);
> +MODULE_PARM_DESC(dump_infos, "Dump card infos while probing. Default=
: 0 (Off)");

