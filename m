From: =?UTF-8?Q?Einar_J=C3=B3n?= <tolvupostur@gmail.com>
Subject: [PATCH] can: c_can_pci set device pointer
Date: Fri, 12 Aug 2016 13:50:41 +0200
Message-ID: <CABhNV20Tv3LxJw=e_JhP-tGwpFz3qNeGo1dUV8HZW6wQUMf1ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33056 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbcHLLwD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2016 07:52:03 -0400
Received: by mail-oi0-f65.google.com with SMTP id s207so1917982oie.0
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2016 04:50:42 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

The priv->device pointer for c_can_pci is never set, but it is used
without a null check in
drivers/net/can/c_can/c_can.c:615:static int c_can_start(struct net_device *dev)
Setting it in c_can_pci_probe() like c_can_plat_probe() prevents
c_can_pci.ko from crashing, with and without CONFIG_PM,

This might also cause the pm_runtime_*() functions in c_can.c to
actually be executed for c_can_pci devices - they are the only other
place where priv->device is used, but they all contain a null check.

---
 drivers/net/can/c_can/c_can_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/c_can/c_can_pci.c
b/drivers/net/can/c_can/c_can_pci.c
index 7be393c..cf7c189 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -161,6 +161,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,

     dev->irq = pdev->irq;
     priv->base = addr;
+    priv->device = &pdev->dev;

     if (!c_can_pci_data->freq) {
         dev_err(&pdev->dev, "no clock frequency defined\n");
-- 
1.9.1
