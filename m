From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
Date: Fri, 22 Feb 2019 11:05:39 -0600
Message-ID: <d1a71f1f-55b8-0ff1-1507-75d7c6237d90@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <52148371-16aa-b87a-02f0-9037d5d34988@ti.com>
 <43e01edf-9b9a-c68d-ec1a-218a8117f59e@grandegger.com>
 <50a3a5d6-9b83-f0aa-095c-13b6361236ab@grandegger.com>
 <b60b8781-d979-24e7-805a-95f9237c816e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b60b8781-d979-24e7-805a-95f9237c816e@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Wolfgang

On 2/22/19 6:50 AM, Dan Murphy wrote:
> Wolfgang
> 
> On 2/22/19 3:38 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> what kernel version is that patch series for. I have problems to apply it!
>>
> 
> It is based off of Master
> 
> commit 2137397c92aec3713fa10be3c9b830f9a1674e60 (linux_master/master)
> 
> And I successfully rebased on top of
> 
> commit 8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4 (linux_master/master)
> Merge tag 'ceph-for-5.0-rc8' of git://github.com/ceph/ceph-client
> 

I just pulled these patches and they applied fine to the top commit of linux master

Do I need to rebase on top of a for-next branch for you?

Dan

> Dan
> 
>> Wolfgang.
>>
>> Am 21.02.19 um 17:41 schrieb Wolfgang Grandegger:
>>> Hello Dan,
>>>
>>> I will have a closer look end of this week!
>>>
>>> Wolfgang.
>>>
>>> Am 21.02.19 um 17:24 schrieb Dan Murphy:
>>>> Bump
>>>>
>>>> On 2/14/19 12:27 PM, Dan Murphy wrote:
>>>>> Hello
>>>>>
>>>>> OK I did not give up on this patch series just got a little preoccupied with
>>>>> some other kernel work.  But here is the update per the comments.
>>>>>
>>>>> It should be understood I broke these out for reviewability.
>>>>> For instance the first patch does not compile on its own as including this
>>>>> patch should not change the current functionality and it pulls all the io-mapped
>>>>> code from the m_can base file to a platfrom file.
>>>>>
>>>>> The next patch "Migrate the m_can code to use the framework"
>>>>> is the change to the kernel for the io-mapped conversion from a flat file to use
>>>>> the framework.  Finally the rename patch just renames the m_can_priv to 
>>>>> m_can_classdev.  I broke this change out specifically for readability of the
>>>>> migration patch per comments on the code.
>>>>>
>>>>> AFAIC the first 3 patches can all be squashed into a single patch.  Or the
>>>>> first 2 patches in the series can be re-arranged but then m_can functionality is
>>>>> affected in the migration patch.
>>>>>
>>>>> Again the first 3 patches here are all just for readability and review purposes.
>>>>>
>>>>> Dan
>>>>>
>>>>> Dan Murphy (5):
>>>>>   can: m_can: Create a m_can platform framework
>>>>>   can: m_can: Migrate the m_can code to use the framework
>>>>>   can: m_can: Rename m_can_priv to m_can_classdev
>>>>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>>>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>>>>
>>>>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
>>>>>  drivers/net/can/m_can/Kconfig                 |  14 +-
>>>>>  drivers/net/can/m_can/Makefile                |   2 +
>>>>>  drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
>>>>>  drivers/net/can/m_can/m_can.h                 | 159 ++++
>>>>>  drivers/net/can/m_can/m_can_platform.c        | 198 +++++
>>>>>  drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
>>>>>  7 files changed, 1320 insertions(+), 409 deletions(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>>>
>>>>
>>>>
> 
> 


-- 
------------------
Dan Murphy
