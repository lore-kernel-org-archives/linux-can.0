From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Need help in interpreting ip status output
Date: Mon, 23 Mar 2020 12:16:18 +0100
Message-ID: <ece51328-6b3d-c8c3-0a38-cea39f71270c@gmx.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
 <2cd75c78-cec7-09c0-ea80-fbedf37d37d5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgCWLQX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 07:16:23 -0400
In-Reply-To: <2cd75c78-cec7-09c0-ea80-fbedf37d37d5@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Alex Blasche <alexander.blasche@qt.io>

Thanks Marc! I'll forward this information.

Best regards,
Andr=C3=A9

On 23.03.20 08:44, Marc Kleine-Budde wrote:
> On 3/21/20 4:19 PM, Andr=C3=A9 Hartmann wrote:
>> Actually it's not my system. The report is from a customer doing a full
>> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610
>
> Which exact kernel are you using?
> Don't run any applications and/or kernel logs over the serial console.
>
>> I guess the customer should try a more recent Kernel than 4.14 first?
>
> Ack.
>
> Marc
>
