From: Flavio Suligoi <f.suligoi@asem.it>
Subject: Re: [PATCH v4] can: sja1000: plx_pci: add support for ASEM CAN raw
 device
Date: Tue, 7 Aug 2018 14:50:34 +0000
Message-ID: <10b11fc8317e41888204fa6378580908@asem.it>
References: <53dae6d6-c25b-71d5-b43f-1d444d9c352b@pengutronix.de>
 <1533626239-4065-1-git-send-email-f.suligoi@asem.it>,<e5e06710-0304-0cf9-67fb-1e29f0678c86@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <e5e06710-0304-0cf9-67fb-1e29f0678c86@pengutronix.de>
Content-Language: it-IT
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S . Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On 08/07/2018 04:11 PM, Marc Kleine-Budde wrote:

>On 08/07/2018 09:17 AM, Flavio Suligoi wrote:
>> This patch adds support for ASEM opto-isolated dual channels
>> CAN raw device (http://www.asem.it)
>>
>> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
>> ---
>>
>> v2: - rename ASEM_... constants to reduce space size;
>>     - remove "else" in "plx_pci_reset_asem_dual_can_raw" function to avoid
>>       strings breaking
>> v3: - fix wrong comment for PLX_LINT2_POL
>>     - put string into just one line in "plx_pci_reset_asem_dual_can_raw"
>>       function
>> v4: - remove unnecessary variable "reset_bar" in
>>       "plx_pci_reset_asem_dual_can_raw" function
>>
>>  drivers/net/can/sja1000/Kconfig   |  1 +
>>  drivers/net/can/sja1000/plx_pci.c | 66 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
>> index 1e65cb6..f6dc899 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -88,6 +88,7 @@ config CAN_PLX_PCI
>>          - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
>>          - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
>>          - Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card (http://www.connecttech.com)
>> +        - ASEM CAN raw - 2 isolated CAN channels (www.asem.it)
>>
>>  config CAN_TSCAN1
>>       tristate "TS-CAN1 PC104 boards"
>> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
>> index f8ff25c..79fc327 100644
>> --- a/drivers/net/can/sja1000/plx_pci.c
>> +++ b/drivers/net/can/sja1000/plx_pci.c
>> @@ -46,7 +46,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
>>                       "esd CAN-PCIe/2000, "
>>                       "Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
>>                       "IXXAT PC-I 04/PCI, "
>> -                     "ELCUS CAN-200-PCI")
>> +                     "ELCUS CAN-200-PCI, "
>> +                     "ASEM DUAL CAN-RAW")
>>  MODULE_LICENSE("GPL v2");
>>
>>  #define PLX_PCI_MAX_CHAN 2
>> @@ -70,7 +71,9 @@ struct plx_pci_card {
>>                                        */
>>
>>  #define PLX_LINT1_EN 0x1             /* Local interrupt 1 enable */
>> +#define PLX_LINT1_POL        (1 << 1)        /* Local interrupt 1 polarity */
>>  #define PLX_LINT2_EN (1 << 3)        /* Local interrupt 2 enable */
>> +#define PLX_LINT2_POL        (1 << 4)        /* Local interrupt 2 polarity */
>>  #define PLX_PCI_INT_EN       (1 << 6)        /* PCI Interrupt Enable */
>>  #define PLX_PCI_RESET        (1 << 30)       /* PCI Adapter Software Reset */
>>
>> @@ -92,6 +95,9 @@ struct plx_pci_card {
>>   */
>>  #define PLX_PCI_OCR  (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
>>
>> +/* OCR setting for ASEM Dual CAN raw */
>> +#define ASEM_PCI_OCR 0xfe
>> +
>>  /*
>>   * In the CDR register, you should set CBP to 1.
>>   * You will probably also want to set the clock divider value to 7
>> @@ -145,10 +151,20 @@ struct plx_pci_card {
>>  #define MOXA_PCI_VENDOR_ID           0x1393
>>  #define MOXA_PCI_DEVICE_ID           0x0100
>>
>> +#define ASEM_RAW_CAN_VENDOR_ID               0x10b5
>> +#define ASEM_RAW_CAN_DEVICE_ID               0x9030
>> +#define ASEM_RAW_CAN_SUB_VENDOR_ID   0x3000
>> +#define ASEM_RAW_CAN_SUB_DEVICE_ID   0x1001
>> +#define ASEM_RAW_CAN_SUB_DEVICE_ID_BIS       0x1002
>> +#define ASEM_RAW_CAN_RST_REGISTER    0x54
>> +#define ASEM_RAW_CAN_RST_MASK_CAN1   0x20
>> +#define ASEM_RAW_CAN_RST_MASK_CAN2   0x04
>> +
>>  static void plx_pci_reset_common(struct pci_dev *pdev);
>>  static void plx9056_pci_reset_common(struct pci_dev *pdev);
>>  static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
>>  static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev);
>> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev);
>>
>>  struct plx_pci_channel_map {
>>       u32 bar;
>> @@ -269,6 +285,14 @@ static struct plx_pci_card_info plx_pci_card_info_moxa = {
>>        /* based on PLX9052 */
>>  };
>>
>> +static struct plx_pci_card_info plx_pci_card_info_asem_dual_can = {
>> +     "ASEM Dual CAN raw PCI", 2,
>> +     PLX_PCI_CAN_CLOCK, ASEM_PCI_OCR, PLX_PCI_CDR,
>> +     {0, 0x00, 0x00}, { {2, 0x00, 0x00}, {4, 0x00, 0x00} },
>> +     &plx_pci_reset_asem_dual_can_raw
>> +     /* based on PLX9030 */
>> +};
>> +
>>  static const struct pci_device_id plx_pci_tbl[] = {
>>       {
>>               /* Adlink PCI-7841/cPCI-7841 */
>> @@ -375,6 +399,20 @@ static const struct pci_device_id plx_pci_tbl[] = {
>>               0, 0,
>>               (kernel_ulong_t)&plx_pci_card_info_moxa
>>       },
>> +     {
>> +             /* ASEM Dual CAN raw */
>> +             ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
>> +             ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
>> +             0, 0,
>> +             (kernel_ulong_t)&plx_pci_card_info_asem_dual_can
>> +     },
>> +     {
>> +             /* ASEM Dual CAN raw -new model */
>> +             ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
>> +             ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
>> +             0, 0,
>> +             (kernel_ulong_t)&plx_pci_card_info_asem_dual_can
>> +     },
>>       { 0,}
>>  };
>>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
>> @@ -524,6 +562,32 @@ static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev)
>>       }
>>  }
>>
>> +/* Special reset function for ASEM Dual CAN raw card */
>> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev)
>> +{
>> +     void __iomem *bar0_addr;
>> +     u8 tmpval;
>> +
>> +     plx_pci_reset_common(pdev);
>> +
>> +     bar0_addr = pci_iomap(pdev, 0, 0);
>> +     if (!bar0_addr) {
>> +             dev_err(&pdev->dev, "Failed to remap reset space %d (BAR%d)\n",
>> +                     0, 0);
>
>I've put both 0 directly into the string while applying the patch.
>
>Tnx,
>Marc

Thanks,
Flavio

>
>--
>Pengutronix e.K.                  | Marc Kleine-Budde           |
>Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
