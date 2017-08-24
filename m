From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 24 Aug 2017 14:31:59 +0200
Message-ID: <b32cc214-1377-32a5-8375-9dc377bcbfba@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
 <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
 <551518df-734a-bea1-8685-eda3773b3474@hartkopp.net>
 <e5fc9061-c463-1c58-40a8-661acd05ee82@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:29931 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdHXMcB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 08:32:01 -0400
In-Reply-To: <e5fc9061-c463-1c58-40a8-661acd05ee82@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hi Marc,

On 08/17/2017 04:08 PM, Marc Kleine-Budde wrote:
> On 08/17/2017 03:54 PM, Oliver Hartkopp wrote:

> 
>> Just to get an impression about the j1939 data structures:
>>
>> Would the per-device memory increase significantly when CAN_J1939 is
>> enabled? Or is it some array of pointers which would be added?
> 
> An array with 256 members
> 
>> 	struct addr_ent {
>> 		ktime_t rxtime;
>> 		struct j1939_ecu *ecu;
>> 		/* count users, to help transport protocol */
>> 		int nusers;
>> 	} ents[256];
> 
> and some more stuff. Sums up to sizeof(priv)=4184 Byte on armv5 (32bit).

Ok - convinced :-)

Moving the filter and j1939 specific data structures into the CAN netdev 
private data space makes sense from the code simplicity and robustness 
perspective.

Although I'm not convinced about the renaming of data structures and 
variable names as it doesn't always increase the readability IMO.

Also include/linux/can/can-ml.h should be named differently, e.g.

  include/linux/can/mlpriv.h
  include/linux/can/midlayer.h
  include/linux/can/ml.h

And there should be some more documentation inside this include file 
that makes clear that this weird include path

#include "../../net/can/af_can.h"

is intended to store midlayer content in netdev data strctures.

I'll go through your data structure rename orgy and comment these 
changes patch by patch ;-)

Best regards,
Oliver
