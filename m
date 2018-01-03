From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v6 4/6] can: m_can: Support higher speed CAN-FD bitrates
Date: Wed, 3 Jan 2018 18:25:28 +0530
Message-ID: <dce9ff7d-239b-9ae3-a738-d4fec4249c86@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>
 <f2a063cd-9456-c21d-2544-02179e0f4f27@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2a063cd-9456-c21d-2544-02179e0f4f27@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

Hi,

On Tuesday 02 January 2018 07:05 PM, Marc Kleine-Budde wrote:
> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>
>> During test transmitting using CAN-FD at high bitrates (> 2 Mbps)
>> would fail. Scoping the signals I noticed that only a single bit
>> was being transmitted and with a bit more investigation realized the actual
>> MCAN IP would go back to initialization mode automatically.
>>
>> It appears this issue is due to the MCAN needing to use the Transmitter
>> Delay Compensation Mode with the correct value for the transmitter delay
>> compensation offset (tdco). What impacts the tdco value isn't 100% clear
>> but to calculate it you use an equation defined in the MCAN User's Guide.
>>
>> The user guide mentions that this register needs to be set based on clock
>> values, secondary sample point and the data bitrate. One of the key
>> variables that can't automatically be determined is the secondary
>> sample point (ssp). This ssp is similar to the sp but is specific to this
>> transmitter delay compensation mode. The guidelines for configuring
>> ssp is rather vague but via some CAN test it appears for DRA76x that putting
>> the value same as data sampling point works.
>>
>> The CAN-CIA's "Bit Time Requirements for CAN FD" paper presented at
>> the International CAN Conference 2013 indicates that this TDC mode is
>> only needed for data bit rates above 2.5 Mbps. Therefore, only enable
>> this mode when the data bit rate is above 2.5 Mbps.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index 53e764f..371ffc1 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -127,6 +127,12 @@ enum m_can_mram_cfg {
>>  #define DBTP_DSJW_SHIFT		0
>>  #define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
>>  
>> +/* Transmitter Delay Compensation Register (TDCR) */
>> +#define TDCR_TDCO_SHIFT		8
>> +#define TDCR_TDCO_MASK		(0x7F << TDCR_TDCO_SHIFT)
>> +#define TDCR_TDCF_SHIFT		0
>> +#define TDCR_TDCF_MASK		(0x7F << TDCR_TDCF_SHIFT)
>> +
>>  /* Test Register (TEST) */
>>  #define TEST_LBCK		BIT(4)
>>  
>> @@ -991,7 +997,8 @@ static int m_can_set_bittiming(struct net_device *dev)
>>  	const struct can_bittiming *bt = &priv->can.bittiming;
>>  	const struct can_bittiming *dbt = &priv->can.data_bittiming;
>>  	u16 brp, sjw, tseg1, tseg2;
>> -	u32 reg_btp;
>> +	u32 reg_btp, tdco, ssp;
> 
> Please move the tdco and the ssp into "if (dbt->bitrate > 2500000)" scope.

Ok.

> 
> Initialize "reg_btp = 0", see below.
> 
>> +	bool enable_tdc = false;
> 
> Please remove, see below.
> 
>>  
>>  	brp = bt->brp - 1;
>>  	sjw = bt->sjw - 1;
>> @@ -1006,9 +1013,41 @@ static int m_can_set_bittiming(struct net_device *dev)
>>  		sjw = dbt->sjw - 1;
>>  		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
>>  		tseg2 = dbt->phase_seg2 - 1;
>> +
>> +		/* TDC is only needed for bitrates beyond 2.5 MBit/s.
>> +		 * This is mentioned in the "Bit Time Requirements for CAN FD"
>> +		 * paper presented at the International CAN Conference 2013
>> +		 */
>> +		if (dbt->bitrate > 2500000) {
>> +			/* Use the same value of secondary sampling point
>> +			 * as the data sampling point
>> +			 */
>> +			ssp = dbt->sample_point;
>> +
>> +			/* Equation based on Bosch's M_CAN User Manual's
>> +			 * Transmitter Delay Compensation Section
>> +			 */
>> +			tdco = (priv->can.clock.freq / 1000) *
>> +			       ssp / dbt->bitrate;
>> +
>> +			/* Max valid TDCO value is 127 */
>> +			if (tdco > 127) {
>> +				netdev_warn(dev, "TDCO value of %u is beyond maximum limit. Disabling Transmitter Delay Compensation mode\n",
> 
> "maximum limit"? Either "maximum" or "limit" should be enough. If the
> value is above 127, does it make sense to disable the tdco completely?

I guess we can put the closest possible value (127) so that the ssp
calculated by the IP is as close to the chosen one as possible.

> 
>> +					    tdco);
>> +			} else {
>> +				enable_tdc = true;
> 
> Why not set "reg_btp |= DBTP_TDC;" here directly?
> 
>> +				m_can_write(priv, M_CAN_TDCR,
>> +					    tdco << TDCR_TDCO_SHIFT);
>> +			}
>> +		}
>> +
>>  		reg_btp = (brp << DBTP_DBRP_SHIFT) | (sjw << DBTP_DSJW_SHIFT) |
>>  			(tseg1 << DBTP_DTSEG1_SHIFT) |
>>  			(tseg2 << DBTP_DTSEG2_SHIFT);
> 
> Adjust this to "reg_btp |=".
> 
>> +
>> +		if (enable_tdc)
>> +			reg_btp |= DBTP_TDC;
> 
> Please remove.

Sure, will remove.

Thanks,
Faiz
