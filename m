From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: m_can: Add Documentation for
 transceiver regulator
Date: Mon, 9 Mar 2020 20:00:23 +0530
Message-ID: <8400282d-8003-549b-3560-5b55b318e57a@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
 <20200217142836.23702-2-faiz_abbas@ti.com> <20200219203529.GA21085@bogus>
 <a987bcd7-ca1c-dfda-72f3-cd2004a87ea5@ti.com>
 <20b86553-9b98-1a9d-3757-54174aa67c62@pengutronix.de>
 <72e4b1f4-e7f1-cccd-6327-0c8ab6f9f9a7@ti.com>
 <679bdfd3-5325-b903-de5f-1beb5b577d73@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <679bdfd3-5325-b903-de5f-1beb5b577d73@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lgirdwood@gmail.com, netdev@vger.kernel.org, sriram.dash@samsung.com, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, broonie@kernel.org, wg@grandegger.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, dmurphy@ti.com
List-Id: linux-can.vger.kernel.org

Hi Marc,

On 02/03/20 1:46 pm, Faiz Abbas wrote:
> Marc,
> 
> On 26/02/20 2:40 pm, Faiz Abbas wrote:
>> Hi Marc,
>>
>> On 21/02/20 2:01 pm, Marc Kleine-Budde wrote:
>>> On 2/21/20 9:31 AM, Faiz Abbas wrote:
>>>> Hi Rob,
>>>>
>>>> On 20/02/20 2:05 am, Rob Herring wrote:
>>>>> On Mon, Feb 17, 2020 at 07:58:34PM +0530, Faiz Abbas wrote:
>>>>>> Some CAN transceivers have a standby line that needs to be asserted
>>>>>> before they can be used. Model this GPIO lines as an optional
>>>>>> fixed-regulator node. Document bindings for the same.
>>>>>>
>>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
>>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> This has moved to DT schema in my tree, so please adjust it and resend.
>>>>
>>>> Ok.
>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
>>>>>> index ed614383af9c..f17e2a5207dc 100644
>>>>>> --- a/Documentation/devicetree/bindings/net/can/m_can.txt
>>>>>> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
>>>>>> @@ -48,6 +48,9 @@ Optional Subnode:
>>>>>>  			  that can be used for CAN/CAN-FD modes. See
>>>>>>  			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
>>>>>>  			  for details.
>>>>>> +
>>>>>> +- xceiver-supply: Regulator that powers the CAN transceiver.
>>>>>
>>>>> The supply for a transceiver should go in the transceiver node.
>>>>>
>>>>
>>>> Marc, while I have you here, do you agree with this?
>>>
>>> I'll look into the details later today.
>>>
>>
>> Sure. Be sure to take another look at my attempt to use the transceiver
>> with a phy driver some time ago.
>>
>> https://lore.kernel.org/patchwork/patch/1006238/
>>
> 
> Do you have any comments?
> 

Gentle ping.

Thanks,
Faiz
