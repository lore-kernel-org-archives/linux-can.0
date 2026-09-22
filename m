Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B47545D96;
	Tue, 22 Sep 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081207; cv=none; b=FXidIhvpFiDKV8AmLDQ7eauxMVHNyOdbdtSbecfEzl5H3U8i6MsW7bY5yYrGTFraE/89P0hxiOnaRN16kUy/hC7i2slmrEV86deyjYNhE+w4sttdEJojtR0yVJerSWYG86oTS6pTcXxzkPXllhrZ8zLEwfhNNubP5rtqhz3oijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081207; c=relaxed/simple;
	bh=oekyyXLIJMPA27K+I2NeBppt63N2bzDmCIIrdQPSMLw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ahv6KfrrsEYGHkPlLnhEXBaHL3WZHM2sQvTcIt2TesnVFMY+eH1Y7Qg087BGTpJXm9nrU0BGbNCQL/TrT2Cprm95aTV9/lNpQk2mZoH4HLTeHrJpRyh4IiPkBV7WpgtoBP+6h0U0TosVAJXMXzo9Kgt/MVcMygpBE27ZFGWwn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAGhWhlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAGhWhlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2250B1F00893;
	Tue, 22 Sep 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081205;
	bh=YQI4S6xOFj9aXi6AUyR67yVVE0SDqC7IC5Hc1LzBfws=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=nAGhWhlWj6Yfak/TednGBs8oSvV7A0dVDkm8cozkzoi2aymCMHDflhz+T9KNMw+vx
	 YXbbtRX7X2QiwqrBdPqYRsgFUvTod+V7lR5rOvSluJVozEuKkH1C28Q9W4Vk4j2v7I
	 xFpjASvky2G924z2LOKqpZAXUMROS10jVe2U7/Uqv/i3PBAZgxfmsXGHxVWZd7Sc2d
	 PnN9yamXm//J0ZnzTpxypPO8aBH09dWaxjWOFp9EMj7xNE1orQnmxclKO2S0XK8aW9
	 U4lpK+W/wPS/OCnUHFnR3QXXeiVKpJ+DpMxRHk+mdRuSoLFK+yRe3ejpHKXYhAfd5r
	 l02lNajC0SMIA==
Date: Tue, 22 Sep 2026 07:46:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
In-Reply-To: <20260922102258.138753-3-quchaosheng000406@163.com>
References: <20260922102258.138753-1-quchaosheng000406@163.com>
 <20260922102258.138753-3-quchaosheng000406@163.com>
Message-Id: <179008111842.3145564.13410709686921168865.robh@kernel.org>
Subject: Re: [PATCH v8 2/3] dt-bindings: net: can: holt,hi311x: Convert to
 DT schema


On Tue, 22 Sep 2026 18:22:57 +0800, Quchaosheng wrote:
> Convert the Holt HI-311X binding from free-form text to DT schema.
> 
> Reference can-controller.yaml and spi/spi-peripheral-props.yaml. The
> HI-3110 sits on an SPI bus, so its node carries the standard SPI
> properties, spi-max-frequency among them. With unevaluatedProperties:
> false and no reference to spi-peripheral-props.yaml, dtbs_check rejects
> those properties:
> 
>   can@1 (holt,hi3110): Unevaluated properties are not allowed
>     ('spi-max-frequency' was unexpected)
> 
> Keep the properties and the example as the original text describes them,
> including clocks as a required property.
> 
> Assisted-by: LLM
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260922084542.104788-1-quchaosheng000406@163.com?part=2
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> 
> v8:
>  - Put back the $ref to spi/spi-peripheral-props.yaml. v7 dropped it as
>    redundant, but the HI-3110 is an SPI peripheral and its node carries
>    spi-max-frequency. With unevaluatedProperties: false and no reference,
>    dt_binding_check reports:
> 
>      can@1 (holt,hi3110): Unevaluated properties are not allowed
>        ('spi-max-frequency' was unexpected)
> 
>    A node carrying spi-max-frequency fails without the reference and passes
>    with it, so the reference is required. Reported by sashiko.
> 
>    The schema is identical to the v6 that Rob reviewed, so his Reviewed-by
>    is kept.
>  .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
>  .../bindings/net/can/holt_hi311x.txt          | 23 -------
>  2 files changed, 67 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.example.dtb: emc-table@83400000 (nvidia,tegra210-emc-table): {'compatible': ['nvidia,tegra210-emc-table'], 'reg': [[2202009600, 65536]], 'phandle': 2, '$nodename': ['emc-table@83400000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml
Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.example.dtb: qman-fqd (fsl,qman-fqd): {'compatible': ['fsl,qman-fqd'], 'size': 4194304, 'alignment': 4194304, 'no-map': True, '$nodename': ['qman-fqd']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['size']}
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,qman-fqd.yaml
Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.example.dtb: qman-fqd (fsl,qman-fqd): Unevaluated properties are not allowed ('alignment', 'no-map', 'size' were unexpected)
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,qman-fqd.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: dsp-memory@98000000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[2550136832, 8388608]], 'reusable': True, 'phandle': 1, '$nodename': ['dsp-memory@98000000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: dsp-memory@98000000 (shared-dma-pool): Unevaluated properties are not allowed ('reg', 'reusable' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: ipu-memory@95800000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 2508193792, 0, 58720256]], 'reusable': True, 'phandle': 2, '$nodename': ['ipu-memory@95800000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: ipu-memory@95800000 (shared-dma-pool): Unevaluated properties are not allowed ('reg', 'reusable' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: dsp1-memory@99000000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 2566914048, 0, 67108864]], 'reusable': True, 'phandle': 3, '$nodename': ['dsp1-memory@99000000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dtb: dsp1-memory@99000000 (shared-dma-pool): Unevaluated properties are not allowed ('reg', 'reusable' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb: m4f-dma-memory@9cb00000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 2628780032, 0, 1048576]], 'no-map': True, 'phandle': 2, '$nodename': ['m4f-dma-memory@9cb00000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb: m4f-dma-memory@9cb00000 (shared-dma-pool): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb: m4f-memory@9cc00000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 2629828608, 0, 14680064]], 'no-map': True, 'phandle': 3, '$nodename': ['m4f-memory@9cc00000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb: m4f-memory@9cc00000 (shared-dma-pool): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/dsp/fsl,dsp.example.dtb: vdev0buffer@94300000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[2486173696, 1048576]], 'no-map': True, 'phandle': 2, '$nodename': ['vdev0buffer@94300000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/dsp/fsl,dsp.example.dtb: vdev0buffer@94300000 (shared-dma-pool): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dtb: reserved-mem@52800000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[1384120320, 1048576]], 'no-map': True, 'phandle': 2, '$nodename': ['reserved-mem@52800000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dtb: reserved-mem@52800000 (shared-dma-pool): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: shmem@f1be0000 (nvidia,tegra264-bpmp-shmem): {'compatible': ['nvidia,tegra264-bpmp-shmem'], 'reg': [[0, 4055760896, 0, 8192]], 'no-map': True, '$nodename': ['shmem@f1be0000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.example.dtb: shmem@f1be0000 (nvidia,tegra264-bpmp-shmem): Unevaluated properties are not allowed ('no-map' was unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
Documentation/devicetree/bindings/reserved-memory/phram.example.dtb: flash@12340000 (phram): {'compatible': ['phram'], 'label': ['rootfs'], 'reg': [[305397760, 8388608]], '$nodename': ['flash@12340000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/phram.yaml
Documentation/devicetree/bindings/reserved-memory/ramoops.example.dtb: ramoops@bfdf0000 (ramoops): {'compatible': ['ramoops'], 'reg': [[3219062784, 65536]], 'console-size': 32768, 'record-size': 1024, 'ecc-size': 16, '$nodename': ['ramoops@bfdf0000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/ramoops.yaml
Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.example.dtb: reserved-memory@85fe0000 (qcom,cmd-db): {'reg': [[2248015872, 131072]], 'compatible': ['qcom,cmd-db'], 'no-map': True, '$nodename': ['reserved-memory@85fe0000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml
Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.example.dtb: reserved-memory@85fe0000 (qcom,cmd-db): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml
Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.example.dtb: wakeup-mailbox@ffff0000 (intel,wakeup-mailbox): {'compatible': ['intel,wakeup-mailbox'], 'reg': [[0, 4294901760, 4096]], '$nodename': ['wakeup-mailbox@ffff0000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml
Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.example.dtb: wakeup-mailbox@ffff0000 (intel,wakeup-mailbox): Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml
Documentation/devicetree/bindings/reserved-memory/google,open-dice.example.dtb: dice@12340000 (google,open-dice): {'compatible': ['google,open-dice'], 'reg': [[0, 305397760, 8192]], 'no-map': True, '$nodename': ['dice@12340000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/google,open-dice.yaml
Documentation/devicetree/bindings/reserved-memory/google,open-dice.example.dtb: dice@12340000 (google,open-dice): Unevaluated properties are not allowed ('no-map' was unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/google,open-dice.yaml
Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.example.dtb: rmtfs@86700000 (qcom,rmtfs-mem): {'compatible': ['qcom,rmtfs-mem'], 'reg': [[2255486976, 917504]], 'no-map': True, 'qcom,client-id': 1, '$nodename': ['rmtfs@86700000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml
Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.example.dtb: rmtfs@86700000 (qcom,rmtfs-mem): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml
Documentation/devicetree/bindings/display/msm/gpu.example.dtb: gpu@8f200000 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 2427453440, 0, 10485760]], 'no-map': True, 'phandle': 5, '$nodename': ['gpu@8f200000']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/display/msm/gpu.example.dtb: gpu@8f200000 (shared-dma-pool): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml
Documentation/devicetree/bindings/firmware/intel,stratix10-svc.example.dtb: svcbuffer@0 (shared-dma-pool): {'compatible': ['shared-dma-pool'], 'reg': [[0, 0, 0, 16777216]], 'alignment': 4096, 'no-map': True, 'phandle': 1, '$nodename': ['svcbuffer@0']} is valid under each of {'if': {'required': ['iommu-addresses']}, 'then': {'required': ['reg']}}, {'required': ['reg']}
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/firmware/intel,stratix10-svc.example.dtb: svcbuffer@0 (shared-dma-pool): Unevaluated properties are not allowed ('alignment', 'no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260922102258.138753-3-quchaosheng000406@163.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

