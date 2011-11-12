From: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Sat, 12 Nov 2011 10:55:10 +0100
Message-ID: <CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<4E4CA945.7080504@hartkopp.net> <4E4CC9D5.6040708@pengutronix.de>
	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>
	<4E5CCAA5.4030009@grandegger.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
	<4EBB8CFD.3050602@grandegger.com>
	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

2011/11/12 Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2011/11/10 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>> Hi Willy,
>>
>> On 11/09/2011 07:03 PM, Willy Lambert wrote:
>>> 2011/9/5 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>> ...
>>>> Ah, at a closer look, the PC/104-Plus is an extension of the PC/104 fr=
om
>>>> factor with an additional connector for PCI. It therefore still suppor=
ts
>>>> ISA bus communication, which the IXXAT PC-I 04/104 board uses.
>>>>
>>>> Therefore I'm going to prepare a patch removing the "X86_32" restricti=
on
>>>> for CONFIG_ISA above. Sorry for confusion.
>>>>
>>>
>>> May I bump this up ? I read your conversation on other linux ML, but I
>>> don't really know how it ended.
>>
>> Some time ago I posted a patch to the relevant mls removing the
>> restriction mentioned above. But enabling CONFIG_ISA also for x86_64
>> systems is not wished mainly to avoid the expected mess with old
>> legacy ISA driver code. Therefore we should convert the driver to a
>> platform driver. I have attached the *untested* patch below. Could you
>> please give it a try? If it works fine, I will send it finally to the
>> netdev ml.
>>
>> Thanks,
>>
>> Wolfgang.
>>
>>
>> From dd2c8d7cf8f23a20aecd234a6cf7675b59f5779d Mon Sep 17 00:00:00 2001
>> From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>> Date: Thu, 10 Nov 2011 09:10:18 +0100
>> Subject: [PATCH] can: sja1000_isa: convert to platform driver to support=
 x86_64 systems
>>
>> This driver is currently not supported on x86_64 systems because the
>> "isa_driver" interface is used. To overcome this limitation, this
>> driver is converted to a platform driver, similar to the serial 8250
>> driver.
>>
>> Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>> ---
>> =A0drivers/net/can/sja1000/Kconfig =A0 =A0 =A0 | =A0 =A01 -
>> =A0drivers/net/can/sja1000/sja1000_isa.c | =A0 86 ++++++++++++++++++++++=
-----------
>> =A02 files changed, 57 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/K=
config
>> index fe9e64d..36e9d59 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -6,7 +6,6 @@ if CAN_SJA1000
>>
>> =A0config CAN_SJA1000_ISA
>> =A0 =A0 =A0 =A0tristate "ISA Bus based legacy SJA1000 driver"
>> - =A0 =A0 =A0 depends on ISA
>> =A0 =A0 =A0 =A0---help---
>> =A0 =A0 =A0 =A0 =A0This driver adds legacy support for SJA1000 chips con=
nected to
>> =A0 =A0 =A0 =A0 =A0the ISA bus using I/O port, memory mapped or indirect=
 access.
>> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja=
1000/sja1000_isa.c
>> index 496223e..3301031 100644
>> --- a/drivers/net/can/sja1000/sja1000_isa.c
>> +++ b/drivers/net/can/sja1000/sja1000_isa.c
>> @@ -17,7 +17,7 @@
>>
>> =A0#include <linux/kernel.h>
>> =A0#include <linux/module.h>
>> -#include <linux/isa.h>
>> +#include <linux/platform_device.h>
>> =A0#include <linux/interrupt.h>
>> =A0#include <linux/netdevice.h>
>> =A0#include <linux/delay.h>
>> @@ -75,6 +75,8 @@ MODULE_PARM_DESC(ocr, "Output control register "
>> =A0#define SJA1000_IOSIZE =A0 =A0 =A0 =A0 =A00x20
>> =A0#define SJA1000_IOSIZE_INDIRECT 0x02
>>
>> +static struct platform_device *sja1000_isa_devs[MAXDEV];
>> +
>> =A0static u8 sja1000_isa_mem_read_reg(const struct sja1000_priv *priv, i=
nt reg)
>> =A0{
>> =A0 =A0 =A0 =A0return readb(priv->reg_base + reg);
>> @@ -115,24 +117,13 @@ static void sja1000_isa_port_write_reg_indirect(co=
nst struct sja1000_priv *priv,
>> =A0 =A0 =A0 =A0outb(val, base + 1);
>> =A0}
>>
>> -static int __devinit sja1000_isa_match(struct device *pdev, unsigned in=
t idx)
>> -{
>> - =A0 =A0 =A0 if (port[idx] || mem[idx]) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq[idx])
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> - =A0 =A0 =A0 } else if (idx)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> -
>> - =A0 =A0 =A0 dev_err(pdev, "insufficient parameters supplied\n");
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> -static int __devinit sja1000_isa_probe(struct device *pdev, unsigned in=
t idx)
>> +static int __devinit sja1000_isa_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 =A0struct net_device *dev;
>> =A0 =A0 =A0 =A0struct sja1000_priv *priv;
>> =A0 =A0 =A0 =A0void __iomem *base =3D NULL;
>> =A0 =A0 =A0 =A0int iosize =3D SJA1000_IOSIZE;
>> + =A0 =A0 =A0 int idx =3D pdev->id;
>> =A0 =A0 =A0 =A0int err;
>>
>> =A0 =A0 =A0 =A0if (mem[idx]) {
>> @@ -203,17 +194,17 @@ static int __devinit sja1000_isa_probe(struct devi=
ce *pdev, unsigned int idx)
>> =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->cdr =3D CDR_DEFAULT;
>>
>> - =A0 =A0 =A0 dev_set_drvdata(pdev, dev);
>> - =A0 =A0 =A0 SET_NETDEV_DEV(dev, pdev);
>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, dev);
>> + =A0 =A0 =A0 SET_NETDEV_DEV(dev, &pdev->dev);
>>
>> =A0 =A0 =A0 =A0err =3D register_sja1000dev(dev);
>> =A0 =A0 =A0 =A0if (err) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pdev, "registering %s failed (err=
=3D%d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "registering %s failed=
 (err=3D%d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRV_NAME, err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_unmap;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 dev_info(pdev, "%s device registered (reg_base=3D0x%p, irq=
=3D%d)\n",
>> + =A0 =A0 =A0 dev_info(&pdev->dev, "%s device registered (reg_base=3D0x%=
p, irq=3D%d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRV_NAME, priv->reg_base, dev->irq);
>> =A0 =A0 =A0 =A0return 0;
>>
>> @@ -229,13 +220,14 @@ static int __devinit sja1000_isa_probe(struct devi=
ce *pdev, unsigned int idx)
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> -static int __devexit sja1000_isa_remove(struct device *pdev, unsigned i=
nt idx)
>> +static int __devexit sja1000_isa_remove(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 =A0 struct net_device *dev =3D dev_get_drvdata(pdev);
>> + =A0 =A0 =A0 struct net_device *dev =3D dev_get_drvdata(&pdev->dev);
>> =A0 =A0 =A0 =A0struct sja1000_priv *priv =3D netdev_priv(dev);
>> + =A0 =A0 =A0 int idx =3D pdev->id;
>>
>> =A0 =A0 =A0 =A0unregister_sja1000dev(dev);
>> - =A0 =A0 =A0 dev_set_drvdata(pdev, NULL);
>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>>
>> =A0 =A0 =A0 =A0if (mem[idx]) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(priv->reg_base);
>> @@ -251,29 +243,65 @@ static int __devexit sja1000_isa_remove(struct dev=
ice *pdev, unsigned int idx)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static struct isa_driver sja1000_isa_driver =3D {
>> - =A0 =A0 =A0 .match =3D sja1000_isa_match,
>> +static struct platform_driver sja1000_isa_driver =3D {
>> =A0 =A0 =A0 =A0.probe =3D sja1000_isa_probe,
>> =A0 =A0 =A0 =A0.remove =3D __devexit_p(sja1000_isa_remove),
>> =A0 =A0 =A0 =A0.driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRV_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> =A0 =A0 =A0 =A0},
>> =A0};
>>
>> =A0static int __init sja1000_isa_init(void)
>> =A0{
>> - =A0 =A0 =A0 int err =3D isa_register_driver(&sja1000_isa_driver, MAXDE=
V);
>> + =A0 =A0 =A0 int idx, err;
>> +
>> + =A0 =A0 =A0 for (idx =3D 0; idx < MAXDEV; idx++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((port[idx] || mem[idx]) && irq[idx]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sja1000_isa_devs[idx] =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_d=
evice_alloc(DRV_NAME, idx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sja1000_isa_devs[idx]=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -E=
NOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_=
free_devices;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D platform_device_ad=
d(sja1000_isa_devs[idx]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_d=
evice_put(sja1000_isa_devs[idx]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_=
free_devices;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: insufficient p=
arameters supplied\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRV_NAME);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_free_devices;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 err =3D platform_driver_register(&sja1000_isa_driver);
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_free_devices;
>> +
>> + =A0 =A0 =A0 pr_info("Legacy %s driver for max. %d devices registered\n=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRV_NAME, MAXDEV);
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +exit_free_devices:
>> + =A0 =A0 =A0 while (--idx >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sja1000_isa_devs[idx])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_unregister=
(sja1000_isa_devs[idx]);
>> + =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Legacy %s driver for max. =
%d devices registered\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRV_NAME, MAXDEV);
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> =A0static void __exit sja1000_isa_exit(void)
>> =A0{
>> - =A0 =A0 =A0 isa_unregister_driver(&sja1000_isa_driver);
>> + =A0 =A0 =A0 int idx;
>> +
>> + =A0 =A0 =A0 platform_driver_unregister(&sja1000_isa_driver);
>> + =A0 =A0 =A0 for (idx =3D 0; idx < MAXDEV; idx++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sja1000_isa_devs[idx])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_unregister=
(sja1000_isa_devs[idx]);
>> + =A0 =A0 =A0 }
>> =A0}
>>
>> =A0module_init(sja1000_isa_init);
>> --
>> 1.7.4.1
>>
>>
>
> I failed to apply the patch, is it for 2.6.38.8 kernels ?
> I even try to modify the file editing by hand, by it doesn't compile.
>
> The command uI use was : ard@ard-host:~/src/linux-2.6.38.8$ patch -p1
> < wg_platform_driver.Patch
> which I think is good because the .rej file is in the right place
> drivers/net/can/sja1000/sja1000_isa.c.rej
>

sorry the mail went to fast, here is the error log :

patching file drivers/net/can/sja1000/sja1000_isa.c
Hunk #2 succeeded at 75 with fuzz 1.
Hunk #3 FAILED at 117.
Hunk #4 FAILED at 205.
Hunk #5 FAILED at 231.
Hunk #6 FAILED at 253.
4 out of 6 hunks FAILED -- saving rejects to file
drivers/net/can/sja1000/sja1000_isa.c.rej
