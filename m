From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 3/7] c_can: use different sets of interface registers
 for rx and tx
Date: Fri, 30 Nov 2012 10:15:53 +0100
Message-ID: <50B87949.70802@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-4-git-send-email-wg@grandegger.com> <50B870B1.4050907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49795 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2K3JQC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 04:16:02 -0500
In-Reply-To: <50B870B1.4050907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 11/30/2012 09:39 AM, Marc Kleine-Budde wrote:
> On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
>> To avoid conflicts between CPU access to the message RAM we now
>> use the first set of interface registers for RX and the second
>> for TX.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/net/can/c_can/c_can.c |   37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
>> index 3ae356f..27e45e6 100644
>> --- a/drivers/net/can/c_can/c_can.c
>> +++ b/drivers/net/can/c_can/c_can.c
>> @@ -158,6 +158,10 @@
>>  #define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
>>  #define RECEIVE_OBJECT_BITS	0x0000ffff
>>  
>> +/* message interface used for rx and tx */
>> +#define IFACE_RX		0
>> +#define IFACE_TX		1
> 
> Can you give these defines a common C_CAN_ prefix? And you can make them
> an enum and change the signature of the function you're changing below.

OK, will do with the next version. Want to be sure that the driver works
as expected first.

Wolfgang

