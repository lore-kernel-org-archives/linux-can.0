From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 2/7] c_can: rename callback "initram" to "init" to more
 general usage
Date: Mon, 03 Dec 2012 15:32:07 +0100
Message-ID: <50BCB7E7.6010707@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-3-git-send-email-wg@grandegger.com> <1876011.7USXKpqpSd@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46426 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab2LCOcK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 09:32:10 -0500
In-Reply-To: <1876011.7USXKpqpSd@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 12/03/2012 03:20 PM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> On Thursday 29 November 2012 15:39:42, Wolfgang Grandegger wrote:
>> The callback "init" is called with the argument "true" when the
>> device is opened and with "false" when it is closed allowing for
>> device specific initialization and cleanup, e.g. raminit or reset.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/net/can/c_can/c_can.c          |   16 ++++++++--------
>>  drivers/net/can/c_can/c_can.h          |    2 +-
>>  drivers/net/can/c_can/c_can_platform.c |    2 +-
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
>> index 5233b8f..3ae356f 100644
>> --- a/drivers/net/can/c_can/c_can.c
>> +++ b/drivers/net/can/c_can/c_can.c
>> @@ -233,10 +233,10 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
>>  		pm_runtime_put_sync(priv->device);
>>  }
>>  
>> -static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
> 
> Where does c_can_reset_ram come from? I can't a patch to it in Linus' tree nor in linux-can repository.

It is in the net-next tree and patches have been posted to this list.

commit 52cde85acc23f61b09dd0376c61eb891125c6990
Author: AnilKumar Ch <anilkumar@ti.com>
Date:   Wed Nov 21 11:14:10 2012 +0530

    can: c_can: Add d_can raminit support

    Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
    which holds all the message objects during transmission or
    receiving of data. This initialization/de-initialization should
    be done in synchronous with D_CAN clock.

    In case of AM335X-EVM (current user of D_CAN driver) message RAM is
    controlled through control module register for both instances. So
    control module register details is required to initialization or
    de-initialization of message RAM according to instance number.

    Control module memory resource is obtained from D_CAN dt node and
    instance number obtained from device tree aliases node.

    This patch was tested on AM335x-EVM along with pinctrl data addition
    patch, d_can dt aliases addition and control module data addition.
    pinctrl data addition is not added to am335x-evm.dts (only supports
    CPLD profile#0) because d_can1 is supported under CPLD profile#1.

    Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
    [mkl: fix instance for non DT in probe, cleaned up raminit]
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Wolfgang.

