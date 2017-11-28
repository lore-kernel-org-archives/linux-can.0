From: Martin Kelly <mkelly@xevo.com>
Subject: Re: [PATCH v2 1/2] can: mcba_usb: fix typo
Date: Tue, 28 Nov 2017 13:09:13 -0800
Message-ID: <1c246910-a55b-f16c-bff7-b93f3310ce7b@xevo.com>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <31e3532f-5899-5d0a-f27a-378fe2ee5124@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:22656
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbdK1VJX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 Nov 2017 16:09:23 -0500
In-Reply-To: <31e3532f-5899-5d0a-f27a-378fe2ee5124@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

On 11/28/2017 12:46 AM, Marc Kleine-Budde wrote:
> On 11/28/2017 12:49 AM, Martin Kelly wrote:
>> Fix typo "analizer" --> "Analyzer".
>>
>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> 
> Both applied to can.
> 

Thanks! By the way as far as I can tell from code inspection, it appears 
that most of the other drivers in net/can/usb should have the same 
disconnect bug. gs_usb appears to be clear, as it returns in its default 
case. Unfortunately mcba_usb is the only device I have to test with, but 
those with other devices may want to check for this.
