From: Efim Monjak <emonjak@lipowsky.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 13:55:41 +0100
Message-ID: <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server1.railshosting.de ([5.45.177.35]:47871 "EHLO
        server1.railshosting.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdCMMxn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 08:53:43 -0400
In-Reply-To: <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Am 13.03.2017 um 10:47 schrieb Marc Kleine-Budde:
> On 03/12/2017 12:06 AM, Oliver Hartkopp wrote:
>> thanks for the patch!
>>
>> In fact I always thought NAPI is too heavy for CAN controllers. NAPI was
>> intended for a very high interrupt load on some ethernet controllers
>> with some considerable RX FIFO.
>>
>> I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving
>> ~22.000 frames/s without any problems, with an one-element FIFO and
>> without NAPI.
>>
>> @Marc: What was the reason to implement NAPI that days? Has it ever been
>> proved that NAPI had a remarkable positive effect in opposite to a
>> direct CAN frame processing in the interrupt context?
> On SMP systems the network stack doesn't seem to guarantee the order of
> frames when put into the stack in IRQ context.
>
> Marc
>

As I see Socketcan use a default queuing discipline pfifo_fast.
This use 3 bands with different priorities, may be here is a problem?

As I test my application I see a queue of about 163000 bytes can contain
only 320 CAN frames. It seems the fifo is not configure for CAN frames 
though
used PDU is 16 bytes.


-- 
Mit freundlichen Grüssen / Best regards
Efim Monjak

------------------------------------------------------------
Lipowsky Industrie-Elektronik GmbH
CAN- & LIN- TOOLS, Embedded Solutions
------------------------------------------------------------
Geschäftsführer/CEO: Andreas Lipowsky
Sitz/domicile:       64291 Darmstadt, Roemerstr. 57
Telefon/phone:       +49-(0)6151-93591-27
Telefax/fax:         +49-(0)6151-93591-28
Handelsregister      Darmstadt HRB 5139
USt-IDNr/VAT-ID:     DE 111647423
Quality Management:  DIN EN ISO 9001:2008
------------------------------------------------------------
Direktzugang: www.lipowsky.de

