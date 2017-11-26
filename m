From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sun, 26 Nov 2017 17:18:29 +0100
Message-ID: <0c2f4a35-3b86-7ae6-ccc6-2751fa92f497@grandegger.com>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
 <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:36356 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdKZQSc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Nov 2017 11:18:32 -0500
In-Reply-To: <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kernel@martin.sperl.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hello Martin,

Am 25.11.2017 um 15:47 schrieb kernel@martin.sperl.org:

...snip...
> I see the following counters:
> 7: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0

Why do you use "ONE_SHOT" in all your test cases?

Did you also check for out-of-order issues, e.g. by using "canfdtest"?

Wolfgang.

