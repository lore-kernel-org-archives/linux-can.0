From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: m_can: enable transmission of FD frame on latest
 version
Date: Mon, 10 Apr 2017 14:09:48 +0200
Message-ID: <6842be63-6517-377d-24f6-6ad68412f98b@hartkopp.net>
References: <20170306022143.7695-1-wenyou.yang@atmel.com>
 <e4360c52-d62d-6c35-f691-7fcd0f74f954@pengutronix.de>
 <b24f3252-6bd9-db48-b224-5bf3683cb75d@hartkopp.net>
 <fe3a4152-643c-404f-f236-5066089fba2e@hartkopp.net>
 <F9F4555C4E01D7469D37975B62D0EFBB4FC29C@CHN-SV-EXMX07.mchp-main.com>
 <2d0bf188-7c80-9dd7-87ec-ef6e4f685f5b@free-electrons.com>
 <2fcc7b32-f7cc-af34-dbab-73aee3fa695b@hartkopp.net>
 <77881e8b-3f69-582a-5827-9fd801758c91@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:18139 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdDJMJ7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Apr 2017 08:09:59 -0400
In-Reply-To: <77881e8b-3f69-582a-5827-9fd801758c91@free-electrons.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>, Wenyou.Yang@microchip.com, mkl@pengutronix.de
Cc: wg@grandegger.com, alexandre.belloni@free-electrons.com, f.fainelli@gmail.com, nicolas.ferre@atmel.com, linux-can@vger.kernel.org, =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>

Hi Quentin,

On 04/10/2017 11:14 AM, Quentin Schulz wrote:
> On 08/04/2017 16:14, Oliver Hartkopp wrote:

>> For that reason I would suggest to upstream Mario's v4 patch set:
>>
>> http://marc.info/?l=linux-can&m=149165343604033&w=2
>> http://marc.info/?l=linux-can&m=149165343304029&w=2
>> http://marc.info/?l=linux-can&m=149165343304030&w=2
>> http://marc.info/?l=linux-can&m=149165343604031&w=2
>> http://marc.info/?l=linux-can&m=149165343604032&w=2
>> http://marc.info/?l=linux-can&m=149165343804036&w=2
>> http://marc.info/?l=linux-can&m=149165343704035&w=2
>>
>> Can you test this patch set on your hardware?
>> This would be very helpful to get some more Tested-by: tags.
>>
>
> I've tested it with sama5_defconfig on next-20170407. Works fine. I
> wasn't in Cc of your patch series Mario and I'm not subscribed to
> linux-can, so answering here instead of in Mario's patch series.
>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Many thanks!

Best regards,
Oliver

