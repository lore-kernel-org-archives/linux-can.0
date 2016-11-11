From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Adding new CAN driver
Date: Fri, 11 Nov 2016 16:40:49 +1100
Message-ID: <5005aa56-80a6-0054-939e-886c3e22c0e8@optusnet.com.au>
References: <3113364.8FuUfmAlHQ@ws-stein>
 <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
 <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net>
 <SG2PR06MB1038E2022EEA5837EB6BD25BC3A60@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
 <20161110091830.GB22657@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:48790 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755964AbcKKGDi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Nov 2016 01:03:38 -0500
In-Reply-To: <20161110091830.GB22657@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 10/11/2016 8:18 PM, Kurt Van Dijck wrote:
> Up to now, I only saw systems that allow to enable 120Ohm,
 > and no other values are coming AFAIK.

ISO/CD 11898-3?

If you don't have the ISO standards, check the second picture in:

https://en.wikipedia.org/wiki/CAN_bus#Architecture

Maybe some 11898-3 transceivers have internal resistors.

Tom

