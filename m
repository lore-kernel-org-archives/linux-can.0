From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: m_can: enable transmission of FD frame on latest
 version
Date: Sat, 8 Apr 2017 16:14:59 +0200
Message-ID: <2fcc7b32-f7cc-af34-dbab-73aee3fa695b@hartkopp.net>
References: <20170306022143.7695-1-wenyou.yang@atmel.com>
 <e4360c52-d62d-6c35-f691-7fcd0f74f954@pengutronix.de>
 <b24f3252-6bd9-db48-b224-5bf3683cb75d@hartkopp.net>
 <fe3a4152-643c-404f-f236-5066089fba2e@hartkopp.net>
 <F9F4555C4E01D7469D37975B62D0EFBB4FC29C@CHN-SV-EXMX07.mchp-main.com>
 <2d0bf188-7c80-9dd7-87ec-ef6e4f685f5b@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:19882 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdDHOPQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Apr 2017 10:15:16 -0400
In-Reply-To: <2d0bf188-7c80-9dd7-87ec-ef6e4f685f5b@free-electrons.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>, Wenyou.Yang@microchip.com, mkl@pengutronix.de
Cc: wg@grandegger.com, alexandre.belloni@free-electrons.com, f.fainelli@gmail.com, nicolas.ferre@atmel.com, linux-can@vger.kernel.org, =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>

Hello Quentin, Wenyou,

On 04/07/2017 01:41 PM, Quentin Schulz wrote:
> On 07/03/2017 02:03, Wenyou.Yang@microchip.com wrote:
>>> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
>>> @Wenyou Yang: Can you please test the two patches posted here:
>>
>> Tested on SAMA5D2 SoC, It works.
>>>
>>> [PATCH 1/2] can: m_can: handle bitrate setup on IP core >= 3.1.x
>>> http://marc.info/?l=linux-can&m=148883529927720&w=2
>>>
>>> [PATCH 2/2] can: m_can: handle frame transmission on IP core >= 3.1.x
>>> http://marc.info/?l=linux-can&m=148883529927718&w=2
>
> Sorry, never received those mails so didn't know I had to do something.
> I forgot to add my Signed-off-by when resending it so of course you can
> add it to your next version:
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>
> That gives me the opportunity to relaunch the discussion on it. What's
> the status?

In fact Mario Hüttel from Bosch posted a real comprehensive update to 
the M_CAN driver which supports *all* M_CAN IP revisions and a TX FIFO 
support which is able to handle proper IFF_ECHO skbs.

For that reason I would suggest to upstream Mario's v4 patch set:

http://marc.info/?l=linux-can&m=149165343604033&w=2
http://marc.info/?l=linux-can&m=149165343304029&w=2
http://marc.info/?l=linux-can&m=149165343304030&w=2
http://marc.info/?l=linux-can&m=149165343604031&w=2
http://marc.info/?l=linux-can&m=149165343604032&w=2
http://marc.info/?l=linux-can&m=149165343804036&w=2
http://marc.info/?l=linux-can&m=149165343704035&w=2

Can you test this patch set on your hardware?
This would be very helpful to get some more Tested-by: tags.

Many thanks,
Oliver
