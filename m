From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH net-next v1] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
Date: Sun, 19 Apr 2020 18:19:12 +0200
Message-ID: <08979629-d9b8-6656-222f-4e84667651a1@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dejin Zheng <zhengdejin5@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-Id: linux-can.vger.kernel.org

> use devm_platform_ioremap_resource_byname() to simplify code,
> it contains platform_get_resource_byname() and
> devm_ioremap_resource(), and also remove some duplicate error
> message.

How do you think about a wording variant like the following?

   Use the function =E2=80=9Cdevm_platform_ioremap_resource_byname=E2=80=
=9D to simplify
   source code which calls the functions =E2=80=9Cplatform_get_resource_by=
name=E2=80=9D
   and =E2=80=9Cdevm_ioremap_resource=E2=80=9D.
   Remove also a few error messages which became unnecessary with this
   software refactoring.


Will any more contributors get into the development mood to achieve
similar collateral evolution by the means of the semantic patch language?
Would you like to increase applications of the Coccinelle software?

Regards,
Markus
