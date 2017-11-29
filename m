From: Martin Kelly <mkelly@xevo.com>
Subject: Re: CAN-USB adapter unplug
Date: Wed, 29 Nov 2017 09:04:29 -0800
Message-ID: <802efa2a-3162-5af6-ac88-a7c3be555c1d@xevo.com>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <31e3532f-5899-5d0a-f27a-378fe2ee5124@pengutronix.de>
 <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>
 <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:28242
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753851AbdK2REr (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Nov 2017 12:04:47 -0500
In-Reply-To: <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

On 11/29/2017 04:20 AM, Marc Kleine-Budde wrote:
> On 11/28/2017 10:09 PM, Martin Kelly wrote:
>>> Both applied to can.
>>
>> Thanks! By the way as far as I can tell from code inspection, it appears
>> that most of the other drivers in net/can/usb should have the same
>> disconnect bug. gs_usb appears to be clear, as it returns in its default
>> case. Unfortunately mcba_usb is the only device I have to test with, but
>> those with other devices may want to check for this.
> 
> Can you create patches for the affected drivers and send them to the
> list and the maintainers of the driver on Cc?
> 

Yes, I can do this, although they will be untested.

> I don't have access to every USB adapter neither.
> 
> Marc
> 
