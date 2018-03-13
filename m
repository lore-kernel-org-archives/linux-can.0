From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH v2 0/1] Open questions
Date: Tue, 13 Mar 2018 18:48:36 +0100
Message-ID: <eb5c728a-e6c2-c610-47ca-a5b3f636a2fc@theobroma-systems.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 13.03.18 18:42, Dr. Philipp Tomsich wrote:
> 
>> On 13 Mar 2018, at 18:40, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com> wrote:
>>
>>>> +    /* get the urb context */
>>>> +    if (WARN_ON(!context))
>>>> +        return;
>>>
>>> Can this happen?
>>
>> Not unless there is a bug in the code. But we want to get a message
>> before dereferencing a pointer.
> 
> Why not use BUG_ON(!context)?

I believe BUG_ON kills the kernel - the intention was to get loud 
message, but we'd rather not crash the user's machine.

Best regards,
Jakob
