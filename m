From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
Date: Thu, 28 Feb 2019 10:44:18 -0600
Message-ID: <caf997cb-25b9-e3b0-3767-173d7c9a4d22@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <10baf726-7783-1783-caaa-d7b78be2d9a0@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10baf726-7783-1783-caaa-d7b78be2d9a0@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Wolfgang

On 2/28/19 10:40 AM, Wolfgang Grandegger wrote:
> Hello,
> 
> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>> Hello
>>
>> OK I did not give up on this patch series just got a little preoccupied with
>> some other kernel work.  But here is the update per the comments.
>>
>> It should be understood I broke these out for reviewability.
>> For instance the first patch does not compile on its own as including this
>> patch should not change the current functionality and it pulls all the io-mapped
>> code from the m_can base file to a platfrom file.
> 
> For git bisection, the code must compile!
> 

So I can squash patch 1 and 2 then.

>> The next patch "Migrate the m_can code to use the framework"
>> is the change to the kernel for the io-mapped conversion from a flat file to use
>> the framework.  Finally the rename patch just renames the m_can_priv to 
>> m_can_classdev.  I broke this change out specifically for readability of the
>> migration patch per comments on the code.
>>
>> AFAIC the first 3 patches can all be squashed into a single patch.  Or the
>> first 2 patches in the series can be re-arranged but then m_can functionality is
>> affected in the migration patch.
> 
> For the reason above, I would squash patch 1 and 2.
> 
>>
>> Again the first 3 patches here are all just for readability and review purposes.>
>> Dan
>>
>> Dan Murphy (5):
>>   can: m_can: Create a m_can platform framework
>>   can: m_can: Migrate the m_can code to use the framework
>>   can: m_can: Rename m_can_priv to m_can_classdev
>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>
>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
>>  drivers/net/can/m_can/Kconfig                 |  14 +-
>>  drivers/net/can/m_can/Makefile                |   2 +
>>  drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
>>  drivers/net/can/m_can/m_can.h                 | 159 ++++
>>  drivers/net/can/m_can/m_can_platform.c        | 198 +++++
>>  drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
>>  7 files changed, 1320 insertions(+), 409 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
> 
> There are plenty of coding-style errors, e.g. white-space, indention,
> line too long, etc. Please use "checkpatch" to find and fix.
> 

Ack.  I missed running it on v5.  I will update in v6.

> Wolfgang.
> 
> 
> 


-- 
------------------
Dan Murphy
