From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 12:57:55 +0200
Message-ID: <4FEAE733.8060401@grandegger.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <4FEAC3EF.3060606@pengutronix.de> <4FEACAAB.1000002@grandegger.com> <4FEAD5CF.9070601@grandegger.com> <4FEAD7B8.2000601@pengutronix.de> <4FEADCB8.80306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60793 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab2F0K6H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 06:58:07 -0400
In-Reply-To: <4FEADCB8.80306@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org, Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>

On 06/27/2012 12:13 PM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> On 06/27/2012 11:43 AM, Wolfgang Grandegger wrote:
>>  
>>> Hi Marc,
>>>
>>> On 06/27/2012 10:56 AM, Wolfgang Grandegger wrote:
>>>    
>>>> On 06/27/2012 10:27 AM, Marc Kleine-Budde wrote:
>>>>      
>>>>> On 06/27/2012 10:19 AM, Hui Wang wrote:
>>>>>        
>>>>>> At least in the i.MX series, the flexcan contrller divides into ver_3
>>>>>> and ver_10, current driver is for ver_3 controller.
>>>>>>
>>>>>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>>>>>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>>>>>> Its reset value is 0xffffffff, this means ID Filter Table must be
>>>>>> checked when receive a packet, but the driver is designed to accept
>>>>>> everything during the chip start, we need to clear this register to
>>>>>> follow this design.
>>>>>>
>>>>>> Add a hw_ver entry in the device tree, this can let us distinguish
>>>>>> which version the controller is, if we don't set value to this entry,
>>>>>> the hw_ver is 3 by default, this is backward compatible for existing
>>>>>> platforms like powerpc and imx35.
>>>>>>           
>>>>> Is it possible to read this value from the hardware?
>>>>> Another possibility would be to introduce a new compatible device
>>>>> in the
>>>>> device tree.
>>>>>         
>>>> I vote for the latter. IIRC, in the past we already had some discussion
>>>> on how to handle version dependent Flexcan hardware, e.g. by using
>>>> flexcan-vX.X or being expicit using fsl,p1010-flexcan. Search for "Add
>>>> support for powerpc" in the netdev mailing list. I added the
>>>> devicetree-discuss ml for that reason.
>>>>       
>>> I looked up the threads and found:
>>>
>>>   http://marc.info/?w=4&r=1&s=Fix+up+fsl-flexcan+device+tree+bi&q=t
>>>
>>> In the Flexcan driver we currently only have:
>>>
>>>   static struct of_device_id flexcan_of_match[] = {
>>>         {
>>>                 .compatible = "fsl,p1010-flexcan",
>>>         },
>>>         {},
>>>   };
>>>
>>> What compatible string do they actually use for the i.MX6Q board? Shawn
>>> or Hui? We need to fix that. From the discussion mentioned above I think
>>>     
> Currently i modified the can1 DT entry in the  imx6q.dtsi like this:
>            flexcan@02090000 { /* CAN1 */
>                reg = <0x02090000 0x4000>;
>                interrupts = <0 110 0x04>;
>                hw-version = <10>;
>            };
> 
> and the DT entry in the imx6q-sabrelite.dts like this:
>            flexcan@02090000 { /* CAN1 */
>                compatible = "fsl,imx6q-flexcan", "fsl,p1010-flexcan";
>                phy-en-gpio = <&gpio1 4 0>;
>                phy-stby-gpio = <&gpio1 2 0>;
>                pinctrl-names = "default";
>                pinctrl-0 = <&pinctrl_flexcan1_1>;
>            };
> if we don't use hw-version entry and use flexcan-v10, do you mean we use
> strcmp or strxxx to decide controller version?

Yes, that could be done wuth that syntax, but ...

> Regards,
> Hui.
>>> "fsl,flexcan-v10" would be acceptable. Unfortunately, we do not known
>>>     
>>
>> As far as I understand the DT, the name should be something like
>>
>> "fsl,${OLDEST_SOCK_THAT_HAS_THIS_VERSION_OF_FLEXCAN}-flexcan".

... the above string is indeed the prefered one, even if I think it's
much less transparent. You should then define the .data field of "struct
of_device_id" to set the hw version.

Wolfgang.


