From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 12:45:15 +0530
Message-ID: <53C4D503.40709@gmail.com>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com> <1405338041-19945-2-git-send-email-b29396@freescale.com> <53C3D155.8080005@gmail.com> <20140715062712.GA9796@shlinux1.ap.freescale.net> <53C4D0B6.4010302@gmail.com> <53C4D3FC.1030401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59486 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbaGOHQa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jul 2014 03:16:30 -0400
In-Reply-To: <53C4D3FC.1030401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On 07/15/2014 12:40 PM, Marc Kleine-Budde wrote:
> On 07/15/2014 08:56 AM, Varka Bhadram wrote:
>> On 07/15/2014 11:57 AM, Dong Aisheng wrote:
>>> On Mon, Jul 14, 2014 at 06:17:17PM +0530, Varka Bhadram wrote:
>>>> +/* Test Register (TEST) */
>>>> +#define TEST_LBCK    BIT(4)
>>>> +
>>>> +/* CC Control Register(CCCR) */
>>>> +#define CCCR_TEST    BIT(7)
>>>> +#define CCCR_MON    BIT(5)
>>>> +#define CCCR_CCE    BIT(1)
>>>> +#define CCCR_INIT    BIT(0)
>>>> +
>>>> +/* Bit Timing & Prescaler Register (BTP) */
>>>> +#define BTR_BRP_MASK        0x3ff
>>>> +#define BTR_BRP_SHIFT        16
>>>> +#define BTR_TSEG1_SHIFT        8
>>>> +#define BTR_TSEG1_MASK        (0x3f << BTR_TSEG1_SHIFT)
>>>> +#define BTR_TSEG2_SHIFT        4
>>>> +#define BTR_TSEG2_MASK        (0xf << BTR_TSEG2_SHIFT)
>>>> +#define BTR_SJW_SHIFT        0
>>>> +#define BTR_SJW_MASK        0xf
>>>> +
>>>> +/* Error Counter Register(ECR) */
>>>> +#define ECR_RP            BIT(15)
>>>> +#define ECR_REC_SHIFT        8
>>>> +#define ECR_REC_MASK        (0x7f << ECR_REC_SHIFT)
>>>> +#define ECR_TEC_SHIFT        0
>>>> +#define ECR_TEC_MASK        0xff
>>>> +
>>>> +/* Protocol Status Register(PSR) */
>>>> +#define PSR_BO        BIT(7)
>>>> +#define PSR_EW        BIT(6)
>>>> +#define PSR_EP        BIT(5)
>>>> +#define PSR_LEC_MASK    0x7
>>>> +
>>>> +/* Interrupt Register(IR) */
>>>> +#define IR_ALL_INT    0xffffffff
>>>> +#define IR_STE        BIT(31)
>>>> +#define IR_FOE        BIT(30)
>>>> +#define IR_ACKE        BIT(29)
>>>> +#define IR_BE        BIT(28)
>>>> +#define IR_CRCE        BIT(27)
>>>> +#define IR_WDI        BIT(26)
>>>> +#define IR_BO        BIT(25)
>>>> +#define IR_EW        BIT(24)
>>>> +#define IR_EP        BIT(23)
>>>> +#define IR_ELO        BIT(22)
>>>> +#define IR_BEU        BIT(21)
>>>> +#define IR_BEC        BIT(20)
>>>> +#define IR_DRX        BIT(19)
>>>> +#define IR_TOO        BIT(18)
>>>> +#define IR_MRAF        BIT(17)
>>>> +#define IR_TSW        BIT(16)
>>>> +#define IR_TEFL        BIT(15)
>>>> +#define IR_TEFF        BIT(14)
>>>> +#define IR_TEFW        BIT(13)
>>>> +#define IR_TEFN        BIT(12)
>>>> +#define IR_TFE        BIT(11)
>>>> +#define IR_TCF        BIT(10)
>>>> +#define IR_TC        BIT(9)
>>>> +#define IR_HPM        BIT(8)
>>>> +#define IR_RF1L        BIT(7)
>>>> +#define IR_RF1F        BIT(6)
>>>> +#define IR_RF1W        BIT(5)
>>>> +#define IR_RF1N        BIT(4)
>>>> +#define IR_RF0L        BIT(3)
>>>> +#define IR_RF0F        BIT(2)
>>>> +#define IR_RF0W        BIT(1)
>>>> +#define IR_RF0N        BIT(0)
>>>> +#define IR_ERR_STATE    (IR_BO | IR_EW | IR_EP)
>>>> +#define IR_ERR_LEC    (IR_STE    | IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
>>>> +#define IR_ERR_BUS    (IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | IR_BEC \
>>>> +            | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L \
>>>> +            | IR_RF0L)
>>>> +#define IR_ERR_ALL    (IR_ERR_STATE | IR_ERR_BUS)
>>>> +
>>>> +/* Interrupt Line Select (ILS) */
>>>> +#define ILS_ALL_INT0    0x0
>>>> +#define ILS_ALL_INT1    0xFFFFFFFF
>>>> +
>>>> +/* Interrupt Line Enable (ILE) */
>>>> +#define ILE_EINT0    BIT(0)
>>>> +#define ILE_EINT1    BIT(1)
>>>> +
>>>> +/* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
>>>> +#define RXFC_FWM_OFF    24
>>>> +#define RXFC_FWM_MASK    0x7f
>>>> +#define RXFC_FWM_1    (1 << RXFC_FWM_OFF)
>>>> +#define RXFC_FS_OFF    16
>>>> +#define RXFC_FS_MASK    0x7f
>>>> +
>>>> +/* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
>>>> +#define RXFS_RFL    BIT(25)
>>>> +#define RXFS_FF        BIT(24)
>>>> +#define RXFS_FPI_OFF    16
>>>> +#define RXFS_FPI_MASK    0x3f0000
>>>> +#define RXFS_FGI_OFF    8
>>>> +#define RXFS_FGI_MASK    0x3f00
>>>> +#define RXFS_FFL_MASK    0x7f
>>>> +
>>>> +/* Tx Buffer Configuration(TXBC) */
>>>> +#define TXBC_NDTB_OFF    16
>>>> +#define TXBC_NDTB_MASK    0x3f
>>>> +
>>>> +/* Tx Buffer Element Size Configuration(TXESC) */
>>>> +#define TXESC_TBDS_8BYTES    0x0
>>>> +/* Tx Buffer Element */
>>>> +#define TX_BUF_XTD    BIT(30)
>>>> +#define TX_BUF_RTR    BIT(29)
>>>> +
>>>> +/* Rx Buffer Element Size Configuration(TXESC) */
>>>> +#define M_CAN_RXESC_8BYTES    0x0
>>>> +/* Tx Buffer Element */
>>>> +#define RX_BUF_ESI    BIT(31)
>>>> +#define RX_BUF_XTD    BIT(30)
>>>> +#define RX_BUF_RTR    BIT(29)
>>>> +
>>>> +/* Tx Event FIFO Con.guration (TXEFC) */
>>>> +#define TXEFC_EFS_OFF    16
>>>> +#define TXEFC_EFS_MASK    0x3f
>>>> +
>>>> +/* Message RAM Configuration (in bytes) */
>>>> +#define SIDF_ELEMENT_SIZE    4
>>>> +#define XIDF_ELEMENT_SIZE    8
>>>> +#define RXF0_ELEMENT_SIZE    16
>>>> +#define RXF1_ELEMENT_SIZE    16
>>>> +#define RXB_ELEMENT_SIZE    16
>>>> +#define TXE_ELEMENT_SIZE    8
>>>> +#define TXB_ELEMENT_SIZE    16
>>>> Alignment for all the includes
>>>>
>>> What do you mean?
>>>
>> I mean all the #define from top not aligned.
>> It would be looks good if aligned properly.
>>
>> Give common tab spaces for all the #defines...
> As I argumented in my other mail, I prefer one space, so no alignment.
>
I mean in this way....

/* Interrupt Register(IR) */
#define IR_ALL_INT	0xffffffff
#define IR_STE		BIT(31)
#define IR_FOE		BIT(30)
#define IR_ACKE		BIT(29)
#define IR_BE		BIT(28)
#define IR_CRCE		BIT(27)
#define IR_WDI		BIT(26)
#define IR_BO		BIT(25)
#define IR_EW		BIT(24)
#define IR_EP		BIT(23)
#define IR_ELO		BIT(22)
#define IR_BEU		BIT(21)
#define IR_BEC		BIT(20)
.....


-- 
Regards,
Varka Bhadram.

