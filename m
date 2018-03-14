From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Wed, 14 Mar 2018 10:25:04 +0100
Message-ID: <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 14.03.2018 um 10:17 schrieb Wolfgang Grandegger:
> 
> 
> Am 14.03.2018 um 10:14 schrieb Jakob Unterwurzacher:
>> On 14.03.18 10:11, Wolfgang Grandegger wrote:
>>>> +    /* handle error frames */
>>>> +    canid = le32_to_cpu(m->msg.can_msg.id);
>>>> +    if (canid & CAN_ERR_FLAG) {
>>>> +        ucan_handle_error_frame(up, m, canid);
>>>> +        /* drop frame if berr-reporting is off */
>>>> +        if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>>>> +            return;
>>>> +    }
>>>
>>> You still do not generate error messages for state changes, IIUC.
>>
>> The hardware generates error frames on state changes - is that what 
>> you mean?
>>
>> In our testing, the state shows up (and updates) correctly in
>>
>>      ip -details -statistics link show can0
> 
> Counting the state changes is one thing but you should also generate 
> error messages for them.

The usual test here is:

$ candump -td -e any,0:0,#FFFFFFFF

should report proper state changes, if you send messages with

1. no cable connected
2. CAN high and low short-circuited

Also downwards if the hardware error is gone and you continue to send 
messages.

Wolfgang.
