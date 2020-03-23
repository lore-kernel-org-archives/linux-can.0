From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Need help in interpreting ip status output
Date: Mon, 23 Mar 2020 08:44:31 +0100
Message-ID: <2cd75c78-cec7-09c0-ea80-fbedf37d37d5@pengutronix.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgCWHon (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2020 03:44:43 -0400
In-Reply-To: <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Alex Blasche <alexander.blasche@qt.io>

On 3/21/20 4:19 PM, André Hartmann wrote:
> Actually it's not my system. The report is from a customer doing a full
> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610

Which exact kernel are you using?
Don't run any applications and/or kernel logs over the serial console.

> I guess the customer should try a more recent Kernel than 4.14 first?

Ack.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
