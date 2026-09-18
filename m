Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1403C197A;
	Fri, 18 Sep 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697477; cv=none; b=SqWxUamzJQ0iNiVN3ubV7ZeZLaHBLtQQRhP+PXmpxLQWD4ZJSpmfrleOH+uRx8lB9zSkOmj22Tz43uAyzbeym4NYvpbEO8ikpVRdf/TPF8pnuwPPUNsLdQogk/JloBrwkxeOg6o+gN6nFMkrHjIaLuLNGiVkJI5R9SHQJ2oLdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697477; c=relaxed/simple;
	bh=cEISbGiK00UC58ShMoITjPykZWVzlAoXf2fxmAqSLAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWkGeuDy34d/2tdtvAYQ1qdijdb06C0jfpCSI/SsjoD1oZ8MdEeSimLqo/ALn2EuM2x2PrQLyx+1Zlk30ZDCp36EPdhVtxVLnEa9gNKM+m31jbnm9anIodEIPIBXpxc+mO9N6/4PHdwTueFMLhDLtfDgezuA+eRAX1sEEN/sD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bDbsHHQE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bDbsHHQE"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HLGHhX1864779;
	Thu, 17 Sep 2026 19:10:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dubC5oM2qU+4GKATaZzkuHMBM
	z27y3mGmxddTGnTElE=; b=bDbsHHQE6wnt0FZroHnJpdrMXyTpswmFeZb4n7raW
	zPKdmQw9JZ7++G37V/APhV80c3fNes407XmTogON0Efh5OHFbr42s8k9Z7xEi6q9
	vQnX/hy6Z4A0Ha8+EHazZatbItIHkVDoHKoVK1GlKPJVLtzq+/zBcbraQqJku7s/
	cNtuB1gsBsFqXpN26srWqEkcbfuroXFMei9zQX3Bfm4gLITqhAmi8WbkKteC4e/O
	5HhiDj+qoMdHMm43imhDuLtiqCxENUYCm3+M7UFGRYBlueIbNhp5FYRSqq0iqZH+
	Azjw8JrJ4Ig8ZWIcnjbvZfVPWIBbLg+RG0bcqJu4TlH5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4grmcs3732-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:10:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 19:10:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 19:10:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9BDE13F7055;
	Thu, 17 Sep 2026 19:10:37 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:40:31 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH net-next] net: use assign_bit() where applicable
Message-ID: <aqydl2Gao3KFhDSf@rkannoth-OptiPlex-7090>
References: <20260917-net-assign-bit-v1-1-e9c97965e080@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917-net-assign-bit-v1-1-e9c97965e080@nxp.com>
X-Proofpoint-GUID: ePMFN2aTbfCwwfMUL1tbZWiUufOGfzTR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDAyNiBTYWx0ZWRfX7VJZWkAHIq29
 ftizCsDf/FZTWHd2tL79O+tFb+0bZH11JuZL0cqTHhRpK80GYjK224lxB+fVbxRE/KeOj6J/7z6
 rCfmC4LFdRZyn1tSbxgJmy2AodQHsmU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDAyNiBTYWx0ZWRfX43TnihcxWaiT
 wDZ00EJpOABn1xijqBtk5gndIhgd7Rn+vD2frFPNuKKeXDQ1NErBPQLHQlKH52ie/JyexMswQry
 3bLvLJTlm6fzl7/D0ElatilQvkgnlnqgki+P37d13dylrkQRCCgXOtUvsvQ96onOlcFVhBagQdR
 8W/b9F1mvnw0KeU7xfe56q3uKkEC2MX5eabX4mMufY+zEHvcXcukWBneoXEDA0NQ9CGQrSUOTS1
 /TFpdFF/7+tZl4HJ+VR5Cqe3WkoaJXO+i1GDE6BYKwTNBOQX9JeelkUp8DCDaHdnB5WmYuRsum2
 bA69xjwFb2lShjLA5Alw5YW/hZKaSPitwXvA39dGY9CiKulhMyiCW2A/wQdrSOxiLQ5+rvg8qA2
 w2GqnN1H+uv62G4CDjuiH9YJKCCHVH+BKh9W7Y2DWG6Ty7RD6Oryk7i5PTh5NRNTsxy1IoSbHze
 FIhuChl+vYHCFEM/Ouw==
X-Proofpoint-ORIG-GUID: ePMFN2aTbfCwwfMUL1tbZWiUufOGfzTR
X-Authority-Analysis: v=2.4 cv=fbs4WEQF c=1 sm=1 tr=0 ts=6aac9da3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8AirrxEcAAAA:8
 a=M5GUcnROAAAA:8 a=hcKA5laK3LMbEB-jZdAA:9 a=CjuIK1q_8ugA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01

On 2026-09-17 at 18:09:52, Peng Fan (OSS) (peng.fan@oss.nxp.com) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
>

  drivers/net/ethernet/marvell/octeontx2/af/cgx.c    | 10 ++-------
  .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  |  5 +----
  .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 15 +++----------
  .../net/ethernet/marvell/octeontx2/af/rvu_npa.c    | 10 ++-------

For above files

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
