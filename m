From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
Date: Fri, 22 Feb 2019 10:38:27 +0100
Message-ID: <50a3a5d6-9b83-f0aa-095c-13b6361236ab@grandegger.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <52148371-16aa-b87a-02f0-9037d5d34988@ti.com>
 <43e01edf-9b9a-c68d-ec1a-218a8117f59e@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43e01edf-9b9a-c68d-ec1a-218a8117f59e@grandegger.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

what kernel version is that patch series for. I have problems to apply it!

Wolfgang.

Am 21.02.19 um 17:41 schrieb Wolfgang Grandegger:
> Hello Dan,
> 
> I will have a closer look end of this week!
> 
> Wolfgang.
> 
> Am 21.02.19 um 17:24 schrieb Dan Murphy:
>> Bump
>>
>> On 2/14/19 12:27 PM, Dan Murphy wrote:
>>> Hello
>>>
>>> OK I did not give up on this patch series just got a little preoccupied with
>>> some other kernel work.  But here is the update per the comments.
>>>
>>> It should be understood I broke these out for reviewability.
>>> For instance the first patch does not compile on its own as including this
>>> patch should not change the current functionality and it pulls all the io-mapped
>>> code from the m_can base file to a platfrom file.
>>>
>>> The next patch "Migrate the m_can code to use the framework"
>>> is the change to the kernel for the io-mapped conversion from a flat file to use
>>> the framework.  Finally the rename patch just renames the m_can_priv to 
>>> m_can_classdev.  I broke this change out specifically for readability of the
>>> migration patch per comments on the code.
>>>
>>> AFAIC the first 3 patches can all be squashed into a single patch.  Or the
>>> first 2 patches in the series can be re-arranged but then m_can functionality is
>>> affected in the migration patch.
>>>
>>> Again the first 3 patches here are all just for readability and review purposes.
>>>
>>> Dan
>>>
>>> Dan Murphy (5):
>>>   can: m_can: Create a m_can platform framework
>>>   can: m_can: Migrate the m_can code to use the framework
>>>   can: m_can: Rename m_can_priv to m_can_classdev
>>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>>
>>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
>>>  drivers/net/can/m_can/Kconfig                 |  14 +-
>>>  drivers/net/can/m_can/Makefile                |   2 +
>>>  drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
>>>  drivers/net/can/m_can/m_can.h                 | 159 ++++
>>>  drivers/net/can/m_can/m_can_platform.c        | 198 +++++
>>>  drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
>>>  7 files changed, 1320 insertions(+), 409 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>
>>
>>
