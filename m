From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Tue, 19 Jun 2012 09:28:19 +0200
Message-ID: <4FE02A13.4030501@grandegger.com>
References: <4FDF67C3.6020201@hartkopp.net> <4FE02008.6030405@grandegger.com> <4FE02624.2010606@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36896 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2FSH22 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 03:28:28 -0400
In-Reply-To: <4FE02624.2010606@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 06/19/2012 09:11 AM, Oliver Hartkopp wrote:
> On 19.06.2012 08:45, Wolfgang Grandegger wrote:
> 
>> Hi Oliver,
>>
>> On 06/18/2012 07:39 PM, Oliver Hartkopp wrote:
>>> - add new struct canfd_frame
>>> - check identical element offsets in struct can_frame and struct canfd_frame
>>> - new ETH_P_CANFD definition to tag CAN FD skbs correctly
>>> - add CAN_MTU and CANFD_MTU definitions for easy frame and mode detection
>>> - add CAN[FD]_MAX_[DLC|DLEN] helper constants to remove hard coded values
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>  include/linux/can.h      |   55 ++++++++++++++++++++++++++++++++++++++++++----
>>>  include/linux/if_ether.h |    3 ++-
>>>  net/can/af_can.c         |    7 ++++++
>>>  3 files changed, 60 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/can.h b/include/linux/can.h
>>> index 17334c0..25265e7 100644
>>> --- a/include/linux/can.h
>>> +++ b/include/linux/can.h
>>> @@ -46,18 +46,65 @@ typedef __u32 canid_t;
>>>   */
>>>  typedef __u32 can_err_mask_t;
>>>  +#define CAN_MAX_DLC 8
>>> +#define CAN_MAX_DLEN 8
>>> +
>>> +#define CANFD_MAX_DLC 15
>>> +#define CANFD_MAX_DLEN 64
>>> +
> 
> (..)
> 
>>>  struct can_frame {
>>>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>> -	__u8    can_dlc; /* data length code: 0 .. 8 */
>>> +	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
>>>  	__u8    data[8] __attribute__((aligned(8)));
>>>  };
> 
> 
> (..)
> 
>>> + * @data:   CAN FD frame payload (up to 64 byte)
>>> + */
>>> +struct canfd_frame {
>>> +	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>> +	__u8    len;     /* frame payload length in byte (0 .. 64) */
>>> +	__u8    flags;   /* additional flags for CAN FD */
>>> +	__u8    __res0;  /* reserved / padding */
>>> +	__u8    __res1;  /* reserved / padding */
>>> +	__u8    data[64] __attribute__((aligned(8)));
>>
>> Shouldn't we use "CANFD_MAX_DLEN" here (... and maybe above as well)?.
>> IIRC, CANFD_MAX_DLEN might be even 128 in the finalized standard.
>>
> 
> 
> Yes. Good point.
> 
> (..)
> 
>>> -#define ETH_P_CAN	0x000C		/* Controller Area Network      */
>>> +#define ETH_P_CAN	0x000C		/* Controller Area Network (CAN)*/
>>> +#define ETH_P_CANFD	0x000D		/* CAN FD 64 byte payload frames*/
>>
>> Then hardcoding 64 here is also not be nice.
> 
> 
> Yes. Will change that too.
> Even if there's a little chance to have more than 64 bytes it's not the right
> place for this kind of information anyway.
> 
> I would wait until this evening if there are more of these remarks and send a
> v2 then. A review of the documentation would be nice - if everything seems
> clear to you.

Where can I pull/fetch the patches from? IIUC, the latest patch series
you sent is broken.

Wolfgang.
