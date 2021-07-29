package com.hr;

	@FunctionalInterface
	interface StringAnalyzer {
		public boolean analyze(String target, String searchStr);
	}

	class ContainsAnalyzer implements StringAnalyzer {
		public boolean analyze(String target, String searchStr) {
			return target.contains(searchStr);
		}
	}

	class StartWithAnalyzer implements StringAnalyzer {
		public boolean analyze(String target, String searchStr) {
			return target.startsWith(searchStr);
		}
	}

	public class FunctionalInterfaceDemo {

		public static void main(String[] args) {

			StringAnalyzer analyzer;
			String target = "jim is teaching", searchStr = "jim";

			analyzer = new ContainsAnalyzer();
			// analyzer = (t, s) -> t.contains(s); //Lamdba expression
			System.out.println(analyzeString(analyzer, target, searchStr));

			analyzer = new StartWithAnalyzer();
			// analyzer = (t, s) -> t.startsWith(s); //Lamdba expression
			System.out.println(analyzeString(analyzer, target, searchStr));

		}

		private static boolean analyzeString(StringAnalyzer analyzer, String target, String searchStr) {
			return analyzer.analyze(target, searchStr);
		}

	}
