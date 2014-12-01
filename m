From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change
 handling.
Date: Mon, 01 Dec 2014 20:42:09 +0100
Message-ID: <547CC491.3070705@grandegger.com>
References: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net> <547B7CDD.2080202@grandegger.com> <20141201110923.29602.38961@shannon> <6a5747c2d61b278876b6c3154c6a3130@grandegger.com> <20141201115158.1538.64214@shannon> <b4ad671712aef49ca40009d6d2ce6d24@grandegger.com> <20141201122255.3365.66370@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58309 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbaLATmM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 1 Dec 2014 14:42:12 -0500
In-Reply-To: <20141201122255.3365.66370@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On 12/01/2014 01:22 PM, Andri Yngvason wrote:
> Quoting Wolfgang Grandegger (2014-12-01 12:02:33)
>> On Mon, 1 Dec 2014 11:51:58 +0000, Andri Yngvason
>> <andri.yngvason@marel.com> wrote:
>>> Quoting Wolfgang Grandegger (2014-12-01 11:37:03)
>>>> On Mon, 1 Dec 2014 11:09:23 +0000, Andri Yngvason
>>>> <andri.yngvason@marel.com> wrote:
>>>>> Quoting Wolfgang Grandegger (2014-11-30 20:23:57)
>>>>>> On 11/28/2014 01:12 PM, Andri Yngvason wrote:
>>>>>>> Replacing error state change handling with the new mechanism.
>>>>>>>
>>>>>>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>>>>>>> ---
>>>>>>> Changes made since last proposal:
>>>>>>> can: flexcan: add FLEXCAN_HAS_BROKEN_ERR_STATE for i.MX6
>>>>>>> can: flexcan: adapt to newer can_change_state
>>>>>>>
>>>>>>>  drivers/net/can/flexcan.c | 103
>>>>>>>  +++++++++-------------------------------------
>>>>>>>  1 file changed, 19 insertions(+), 84 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>>>>>> index 60f86bd..9f91735 100644
>>>>>>> --- a/drivers/net/can/flexcan.c
>>>>>>> +++ b/drivers/net/can/flexcan.c
>>>>>>> @@ -266,7 +266,7 @@ static struct flexcan_devtype_data
>>>>>>> fsl_p1010_devtype_data = {
>>>>>>>  };
>>>>>>>  static struct flexcan_devtype_data fsl_imx28_devtype_data;
>>>>>>>  static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
>>>>>>> -     .features = FLEXCAN_HAS_V10_FEATURES,
>>>>>>> +     .features = FLEXCAN_HAS_V10_FEATURES |
>>>>>>> FLEXCAN_HAS_BROKEN_ERR_STATE,
>>>>>>
>>>>>> Oops, this change is not related to the subject! Anyway, did it cure
>>>>>> your problems with state handling. Is it required for all i.MX6
>> cores
>>>>>> then?
>>>>>>
>>>>> Yeah, I accidentally squashed this; intended to make this a separate
>>>>> patch. This
>>>>> helps. It has the same effect as enabling berr-reporting. However,
>> this
>>>>> only
>>>>> cures one of the problems. This does not help with the case where no
>>>>> one
>>>>> else is
>>>>> sending on the bus.
>>>>>
>>>>> This problem is not limited to i.MX6. This is a problem for ALL
>> FlexCAN
>>>>> cores.
>>>>> This is a design flaw in FlexCAN cores. Maybe they did this part on a
>>>>> monday
>>>>> after a weekend of binge-drinking. In any case, they really messed up
>>>> with
>>>>> this
>>>>> one.
>>>>
>>>> #define FLEXCAN_HAS_BROKEN_ERR_STATE    BIT(2) /* [TR]WRN_INT not
>>>> connected */
>>>>
>>>> They actually forgot to connect the [TR]WRN_INT line. Don't know what
>>>> they
>>>> did the days before ;).
>>>>
>>> That's not a problem on the i.MX6, but that doesn't matter. The problem
>> is
>>> that
>>> there are no interrupts for the other state transitions. Whether WRN_INT
>> is
>>> connected or not isn't even relevant. WRN_INT is only triggered when
>>> transitioning from error-active to error-warning. Everything else is
>>> missing by
>>> design.
>>
>> But that's another issue.
>>
> Yes, that's the issue that I'm having that requires me to turn on
> berr-reporting or else turn on the bus error interrupts, which is what the flag
> does to deal with the missing connections.
>>
>>>>> I suggest that we remove the FLEXCAN_HAS_BROKEN_ERR_STATE flag and
>> turn
>>>> on
>>>>> error
>>>>> interrupts permanently because they ALL have broken error state. 
>>>>
>>>> Hm, how did you come to this conclusion? You just tested on an i.MX6,
>>>> right?
>>>> Anyway, the bus error reporting can cause very high CPU load and it
>>>> should
>>>> be off when it's not needed.
>>>>
>>> I don't need to test this on other cores because, it can be logically
>>> derived
>>> from the manual that interrupts for error state transitions were not a
>>> part of
>>> the design.
>>>
>>> This may sound quite incredible, but it is my understanding that this is
>>> indeed
>>> the case. I really do hope that I'm wrong, but I doubt it.
>>
>> As I said before. The error reporting is perfect on the SJA1000 and more
>> (for the Flexcan) or less worse on the other CAN controllers.
>>
> 
> Yes. In any case, the warning interrupt is irrelevant, because we have to poll
> the state anyway for the other states. Thus the FLEXCAN_HAS_BROKEN_ERR_STATE
> flag is irrelevant.

Well, it improves the situation a little bit. But now I understand your
point. Yes the Flexcan core is buggy in this respect.

> The question that remains is: Should we enable bus error interrupts for all
> flexcan cores or should we ignore the issue and allow the users to work around
> it (if they wish) using the berr-reporting flag?

Bus error reporting sometimes really harms and therefore I would leave
it as-is. There are also more recent cores and it would be nice to known
if they have improved the reporting of state changes further. Anyway,
this issue should be addressed by a separate patch series.

> There is a middle-ground here: We could enable bus error interrupts when we get
> the error-warning interrupt and disable them again when the state has reached
> error-active again. In that case we would want to keep the BROKEN_ERR_STATE
> flag.

Puh, that's far too sophisticated.

Wolfgang.

