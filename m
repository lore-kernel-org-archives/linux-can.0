From: "Yang, Wenyou" <Wenyou.Yang@Microchip.com>
Subject: Re: AW: AW: [PATCH v4 7/7] can: m_can: Enable TX FIFO Handling for
 M_CAN IP version >= v3.1.x
Date: Wed, 19 Apr 2017 15:11:44 +0800
Message-ID: <f5f6b8f3-0309-f293-6fb8-7874e49aecc7@Microchip.com>
References: <20170408121015.11428-1-mario.huettel@gmx.net>
 <20170408121015.11428-7-mario.huettel@gmx.net>
 <1f88411b-aa58-4e17-02cb-43fc0ffb953c@Microchip.com>
 <a3e6f8f0-8356-4e34-d26c-1cf243caffa0@hartkopp.net>
 <dce17476-21cb-2be8-202f-2662c75d1f3b@free-electrons.com>
 <c04fdd22a8364cc5a6d22f0b957d0fa8@SI-MBX1034.de.bosch.com>
 <ade4d7b4-a440-98ce-3c66-684136cffde7@Microchip.com>
 <18fc2302295643eb935fdb70625163f8@SI-MBX1034.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59715 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbdDSHLu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Apr 2017 03:11:50 -0400
In-Reply-To: <18fc2302295643eb935fdb70625163f8@SI-MBX1034.de.bosch.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Mario,


On 2017/4/18 14:50, Huettel Mario (AE/PJ-SCI1) wrote:
> Hello Wenyou,
>
> The line
> bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
> configures:
> addr. Offset: 0
> 0x sidf
> 0x xidf
> 32x RX FIFO 0
> 0x RX FIFO 1
> 0x RX Buffer
> 0x TXE FIFO
> 1x TX Buffer
>
> Because you are not using the TXE FIFO the driver doesn't detect the transmission of the message and therefore doesn't ree the Buffer.
> The TXE FIFO is needed in my driver approach. And the TX buffer doesn't have to be 1 element. It can be more.
> I would recommend testing something like:
>
> bosch,mram-cfg = <0x0 0 0 32 0 0 10 10>;
> This configures 10 TX Event FIFO elements and 10 TX Buffers/FIFO slots.
> The values are only an example. You can set them to whatever you want as long as they stay in the specified range according to the user's manual.
As your advice, I tested it, it works.

Thanks a lot.

>
> Mario
>
> -----Ursprüngliche Nachricht-----
> Von: Yang, Wenyou [mailto:Wenyou.Yang@Microchip.com]
> Gesendet: Dienstag, 18. April 2017 08:18
> An: Huettel Mario (AE/PJ-SCI1) <Mario.Huettel@de.bosch.com>; Quentin Schulz <quentin.schulz@free-electrons.com>
> Cc: linux-can@vger.kernel.org
> Betreff: Re: AW: [PATCH v4 7/7] can: m_can: Enable TX FIFO Handling for M_CAN IP version >= v3.1.x
>
> Hi Mario,
>
> The device tree patch is attached.
>
> Here is the configure and log.
>
> ---8<----
>
> # ip link set can0 type can bitrate 125000 dbitrate 4000000 fd on
> fd-non-iso on
> # ip link set can1 type can bitrate 125000 dbitrate 4000000 fd on
> fd-non-iso on
> # ip link set can0 up
> # ip link set can1 up
> # ip -details link show can0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>       link/can  promiscuity 0
>       can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0)
> restart-ms 0
>             bitrate 125000 sample-point 0.875
>             tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
>             m_can: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..512 brp-inc 1
>             dbitrate 4000000 dsample-point 0.700
>             dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1
>             m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
>             clock 40000000
> # ip -details link show can1
> 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN
> mode DEFAULT group default qlen 10
>       link/can  promiscuity 0
>       can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0)
> restart-ms 0
>             bitrate 125000 sample-point 0.875
>             tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
>             m_can: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..512 brp-inc 1
>             dbitrate 4000000 dsample-point 0.700
>             dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1
>             m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
>             clock 40000000
> # candump can1 &
> #  cansend can0 5A1##111.22.33.44.55.66.77.88.99.aa.bb.cc
>     can1  5A1  [12]  11 22 33 44 55 66 77 88 99 AA BB CC
> #  cansend can0 5A1##111.22.33.44.55.66.77.88.99.aa.bb.cc
> #
>
> --->8----
>
> Hope it is helpful for you.
>
> Any question, please don't hesitate to come back.
>
>
> Best Regards,
>
> Wenyou Yang
>
>
> On 2017/4/18 14:04, Huettel Mario (AE/PJ-SCI1) wrote:
>> Hi Quentin, hi Wenyou,
>>
>> Today I've received another email that the driver is not working with the
>> M_CAN in Atmel's SAMA5D2.
>>
>> Can you send me the device tree you're using and post the dmesg output
>> of the m_can driver?
>>
>> There might be a clue why it isn't working.
>> The fact that it is working one time and then stops working looks like some problem
>> In the TX FIFO to me. Can you please check with some third device/oscilloscope,
>> if the controller is sending data. I want to know ehre the problem lies. If it's in the TX or
>> RX path.
>>
>> As for now I can only throw some ideas into the round:
>> * What are the PCLK and CCLK values? CCLK >= PCLK?
>> * TX FIFO configured to one element and something happens in that case.
>> * No TX Event FIFO element configured. The driver also doesn't work in this case.
>>
>>
>> Quentin wrote:
>>> Hi Oliver,
>>>
>>> On 13/04/2017 08:30, Oliver Hartkopp wrote:
>>>> Hi Wenyou,
>>>>
>>>> as Quentin had no problems in his setup:
>>>>
>>> Actually just retested by doing the same as Wenyou on my SAMA5D2
>>> Xplained and I can attest I'm having the same behavior as Wenyou.
>>>
>>> Best regards,
>>> Quentin
>> ��칻�&�~�&���+-��ݶ��w��˛���m�b��\jx����ܨ}���Ơz�&j:+v���
> ����zZ+��+zf���h���~����i���z��w���?����&�)ߢf
>
> ��칻�&�~�&���+-��ݶ��w��˛���m�b��\jx����ܨ}���Ơz�&j:+v�������zZ+��+zf���h���~����i���z��w���?����&�)ߢf

Best Regards,
Wenyou Yang

