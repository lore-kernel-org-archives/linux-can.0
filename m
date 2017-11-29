From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Re: CAN-USB adapter unplug
Date: Wed, 29 Nov 2017 16:21:23 +0100
Message-ID: <2f999f02-028e-1e6c-9020-beb5a76889cc@esd.eu>
References: <20171127234916.25865-1-mkelly@xevo.com>
 <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxpout01.htp-tel.de ([212.59.41.8]:63956 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbdK2P3k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Nov 2017 10:29:40 -0500
In-Reply-To: <48029f4a-5137-5f1f-6970-5668fb8da599@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Martin Kelly <mkelly@xevo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>, Wolfgang Grandegger <wg@grandegger.com>

Am 29.11.2017 um 13:20 schrieb Marc Kleine-Budde:
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
> I don't have access to every USB adapter neither.
> 
> Marc
> 

Hi,

I have seen Martin's emails these days and tried to reproduce the error here
with an esd CAN-USB/2 device (handled by esd_usb2.c). The only thing I get 
in the log are some messages like this:

kernel: [14776.152459] usb 2-1: Rx URB aborted (-71)

There is no endless loop. How could I reproduce the bad behavior? For the
quick test I used an Ubuntu 4.4.0-101-generic kernel.

In any case I will add the patch handling EPIPE on a test system and have a 
look what it might change.

Regards,
Stefan Mätje

------------------------------------------------------------------------
Dipl.-Ing. Stefan Mätje
System-Design

esd electronics gmbh                                                    
Vahrenwalder Str. 207 - 30165 Hannover - GERMANY                        
Telefon: 0511-37298-146 - Fax: 0511-37298-68                            
E-Mail: Stefan.Maetje@esd.eu                                            
Bitte besuchen Sie uns im Internet unter http://www.esd.eu              
Quality Products - Made in Germany                                      
------------------------------------------------------------------------
Geschäftsführer: Klaus Detering, Norbert Gemmeke                        
Amtsgericht Hannover HRB 51373 - VAT-ID DE 115672832                    
------------------------------------------------------------------------
