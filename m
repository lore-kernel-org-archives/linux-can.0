From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH v3 2/2] Allwinner A10/A20 CAN Controller support
Date: Sat, 5 Sep 2015 20:37:22 +0200
Message-ID: <CAJ=nTsuYHPv5OjzowBXy0ss02f7PHKxWV-csxV+u1CZP6dOnYQ@mail.gmail.com>
References: <1441376988-2384-1-git-send-email-info@gerhard-bertelsmann.de>
	<1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33611 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbIEShY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Sep 2015 14:37:24 -0400
Received: by lbcjc2 with SMTP id jc2so24902283lbc.0
        for <linux-can@vger.kernel.org>; Sat, 05 Sep 2015 11:37:23 -0700 (PDT)
In-Reply-To: <1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

2015-09-04 16:29 GMT+02:00 Gerhard Bertelsmann <info@gerhard-bertelsman=
n.de>:
>
> This patch adds the Allwinner A10/A20 Kernel module
>
> +
> +/* Registers address */
> +#define CAN_BASE0              0x01C2BC00
> +#define CAN_MSEL_ADDR          0x0000  /* CAN Mode Select */
> +#define CAN_CMD_ADDR            0x0004 /* CAN Command */
> +#define CAN_STA_ADDR           0x0008  /* CAN Status */
> +#define CAN_INT_ADDR           0x000c  /* CAN Interrupt Flag */
> +#define CAN_INTEN_ADDR         0x0010  /* CAN Interrupt Enable */
> +#define CAN_BTIME_ADDR         0x0014  /* CAN Bus Timing 0 */
> +#define CAN_TEWL_ADDR          0x0018  /* CAN Tx Error Warning Limit=
 */
> +#define CAN_ERRC_ADDR          0x001c  /* CAN Error Counter */
> +#define CAN_RMCNT_ADDR         0x0020  /* CAN Receive Message Counte=
r */
> +#define CAN_RBUFSA_ADDR                0x0024  /* CAN Receive Buffer=
 Start Address */
> +#define CAN_BUF0_ADDR          0x0040  /* CAN Tx/Rx Buffer 0 */
> +#define CAN_BUF1_ADDR          0x0044  /* CAN Tx/Rx Buffer 1 */
> +#define CAN_BUF2_ADDR          0x0048  /* CAN Tx/Rx Buffer 2 */
> +#define CAN_BUF3_ADDR          0x004c  /* CAN Tx/Rx Buffer 3 */
> +#define CAN_BUF4_ADDR          0x0050  /* CAN Tx/Rx Buffer 4 */
> +#define CAN_BUF5_ADDR          0x0054  /* CAN Tx/Rx Buffer 5 */
> +#define CAN_BUF6_ADDR          0x0058  /* CAN Tx/Rx Buffer 6 */
> +#define CAN_BUF7_ADDR          0x005c  /* CAN Tx/Rx Buffer 7 */
> +#define CAN_BUF8_ADDR          0x0060  /* CAN Tx/Rx Buffer 8 */
> +#define CAN_BUF9_ADDR          0x0064  /* CAN Tx/Rx Buffer 9 */
> +#define CAN_BUF10_ADDR         0x0068  /* CAN Tx/Rx Buffer 10 */
> +#define CAN_BUF11_ADDR         0x006c  /* CAN Tx/Rx Buffer 11 */
> +#define CAN_BUF12_ADDR         0x0070  /* CAN Tx/Rx Buffer 12 */
> +#define CAN_ACPC_ADDR          0x0040  /* CAN Acceptance Code 0 */
> +#define CAN_ACPM_ADDR          0x0044  /* CAN Acceptance Mask 0 */
> +#define CAN_RBUF_RBACK_START_ADDR      0x0180  /* CAN transmit buffe=
r start */
> +#define CAN_RBUF_RBACK_END_ADDR                0x01b0  /* CAN transm=
it buffer end */
> +
> +/* Controller Register Description */
> +
> +/* mode select register (r/w)
> + * offset:0x0000 default:0x0000_0001
> + */
> +#define SLEEP_MODE             (0x01 << 4)     /* write in reset mod=
e */
> +#define WAKE_UP                        (0x00 << 4)
> +#define SINGLE_FILTER          (0x01 << 3)     /* write in reset mod=
e */
> +#define DUAL_FILTERS           (0x00 << 3)
> +#define LOOPBACK_MODE          BIT(2)
> +#define LISTEN_ONLY_MODE       BIT(1)
> +#define RESET_MODE             BIT(0)
> +
> +/* command register (w)
> + * offset:0x0004 default:0x0000_0000
> + */
> +#define BUS_OFF_REQ            BIT(5)
> +#define SELF_RCV_REQ           BIT(4)
> +#define CLEAR_OR_FLAG          BIT(3)
> +#define RELEASE_RBUF           BIT(2)
> +#define ABORT_REQ              BIT(1)
> +#define TRANS_REQ              BIT(0)
> +
> +/* status register (r)
> + * offset:0x0008 default:0x0000_003c
> + */
> +#define BIT_ERR                        (0x00 << 22)
> +#define FORM_ERR               (0x01 << 22)
> +#define STUFF_ERR              (0x02 << 22)
> +#define OTHER_ERR              (0x03 << 22)
> +#define MASK_ERR               (0x03 << 22)
> +#define ERR_DIR                        BIT(21)
> +#define ERR_SEG_CODE           (0x1f << 16)
> +#define START                  (0x03 << 16)
> +#define ID28_21                        (0x02 << 16)
> +#define ID20_18                        (0x06 << 16)
> +#define SRTR                   (0x04 << 16)
> +#define IDE                    (0x05 << 16)
> +#define ID17_13                        (0x07 << 16)
> +#define ID12_5                 (0x0f << 16)
> +#define ID4_0                  (0x0e << 16)
> +#define RTR                    (0x0c << 16)
> +#define RB1                    (0x0d << 16)
> +#define RB0                    (0x09 << 16)
> +#define DLEN                   (0x0b << 16)
> +#define DATA_FIELD             (0x0a << 16)
> +#define CRC_SEQUENCE           (0x08 << 16)
> +#define CRC_DELIMITER          (0x18 << 16)
> +#define ACK                    (0x19 << 16)
> +#define ACK_DELIMITER          (0x1b << 16)
> +#define END                    (0x1a << 16)
> +#define INTERMISSION           (0x12 << 16)
> +#define ACTIVE_ERROR           (0x11 << 16)
> +#define PASSIVE_ERROR          (0x16 << 16)
> +#define TOLERATE_DOMINANT_BITS (0x13 << 16)
> +#define ERROR_DELIMITER                (0x17 << 16)
> +#define OVERLOAD               (0x1c << 16)
> +#define BUS_OFF                        BIT(7)
> +#define ERR_STA                        BIT(6)
> +#define TRANS_BUSY             BIT(5)
> +#define RCV_BUSY               BIT(4)
> +#define TRANS_OVER             BIT(3)
> +#define TBUF_RDY               BIT(2)
> +#define DATA_ORUN              BIT(1)
> +#define RBUF_RDY               BIT(0)
> +
> +/* interrupt register (r)
> + * offset:0x000c default:0x0000_0000
> + */
> +#define BUS_ERR                        BIT(7)
> +#define ARB_LOST               BIT(6)
> +#define ERR_PASSIVE            BIT(5)
> +#define WAKEUP                 BIT(4)
> +#define DATA_OR                        BIT(3)
> +#define ERR_WRN                        BIT(2)
> +#define TBUF_VLD               BIT(1)
> +#define RBUF_VLD               BIT(0)
> +
> +/* interrupt enable register (r/w)
> + * offset:0x0010 default:0x0000_0000
> + */
> +#define BERR_IRQ_EN            BIT(7)
> +#define ARB_LOST_IRQ_EN                BIT(6)
> +#define ERR_PASSIVE_IRQ_EN     BIT(5)
> +#define WAKEUP_IRQ_EN          BIT(4)
> +#define OR_IRQ_EN              BIT(3)
> +#define ERR_WRN_IRQ_EN         BIT(2)
> +#define TX_IRQ_EN              BIT(1)
> +#define RX_IRQ_EN              BIT(0)
> +
> +/* error code */
> +#define ERR_INRCV              (0x1 << 5)
> +#define ERR_INTRANS            (0x0 << 5)
> +
> +/* filter mode */
> +#define FILTER_CLOSE           0
> +#define SINGLE_FLTER_MODE      1
> +#define DUAL_FILTER_MODE       2
> +
> +/* max. number of interrupts handled in ISR */
> +#define SUNXI_CAN_MAX_IRQ      20
> +

Might be a good idea to use a prefix for all defines to avoid possible
conflicts. Something like SUNXI_.

There have previously been conflicts in the SJA1000 driver, See [1].

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D06e1d1d71876c75bf4a9d3b310c1b4df34e8be69


--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
